//
//  Tweet.swift
//  TweetPath
//
//  Created by Michael Ceraso on 2/17/16.
//  Copyright © 2016 Michael Ceraso. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var tweetUser: NSDictionary?
    var name: String?
    var screenname: String?
    var profileImageURL: NSURL?
    var text: String?
    var createdAt: NSDate?
    var createdAtString: String?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(dictionary: NSDictionary)
        {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        createdAtString = dictionary["created_at"] as? String
  
        if let createdAtString = createdAtString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            createdAt = formatter.dateFromString(createdAtString)
            print("\(createdAtString)")
            }
            
        tweetUser = dictionary["user"] as? NSDictionary
        name = tweetUser!["name"] as? String
        screenname = tweetUser!["screen_name"] as? String
            
        let profileURLString = tweetUser!["profile_image_url"] as? String
            if let profileURLString = profileURLString{
                profileImageURL = NSURL(string: profileURLString)
            }
            
            
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]
        {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
                let tweet = Tweet(dictionary: dictionary)
                
                tweets.append(tweet)
            }
        return tweets
            
        }
}