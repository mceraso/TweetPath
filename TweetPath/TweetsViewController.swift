//
//  TweetsViewController.swift
//  TweetPath
//
//  Created by Michael Ceraso on 2/23/16.
//  Copyright © 2016 Michael Ceraso. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            
            for tweet in tweets{
                print(tweet.text!)
            }
        }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
        
     //   TwitterClient.sharedInstance.currentAccount({ (
     //       user) -> () in
     //       print("all good!")
     //       }) { (error: NSError) -> () in
     //       print("not all good")
     //   }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
