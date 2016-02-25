//
//  TwitterClient.swift
//  TweetPath
//
//  Created by Michael Ceraso on 2/16/16.
//  Copyright © 2016 Michael Ceraso. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "12PihnheUcJpL6p6kjKazzGNl"
let twitterConsumerSecret = "w2q2iwSMtaWFcgRE9z7FoblAkeWEqvHfjOU8u3eWJStTkztxlx"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)

    var loginSuccess: (() -> ())?
    var loginFailure: (NSError -> ())?
    
    func login(success: () -> (), failure: (NSError) -> () ) {
        loginSuccess = success
        loginFailure = failure
        
      //  TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "tweetpath://oauth"), scope: nil,
            success: {(requestToken: BDBOAuth1Credential!) -> Void in
                
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!)
                
        }) { (error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func handleOpenUrl(url: NSURL) {
        
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            self.currentAccount({ (user: User) -> () in
                    User.currentUser = user
                    self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
            
        }) {(error: NSError!) -> Void in
            print("error getting current user")
            self.loginFailure?(error)
        }
    }
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> () ) {
        GET("1.1/statuses/home_timeline.json", parameters: nil,
            success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                // print("Home Timeline: \(response)")
                
                let dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionaries)
                success(tweets)
                
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                failure(error)
        })
    }

    func currentAccount(success: (User) -> (), failure: (NSError) -> () ){
        GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let userDictionary = response as! NSDictionary
                let user = User(dictionary: userDictionary)
            
                success(user)
            
            }, failure: {(operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                failure(error)
        })
    }
    
}
