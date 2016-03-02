//
//  ProfileViewController.swift
//  TweetPath
//
//  Created by Michael Ceraso on 2/27/16.
//  Copyright © 2016 Michael Ceraso. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var tweet: Tweet!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numberFollowersLabel: UILabel!
    @IBOutlet weak var numberTweetsLabel: UILabel!
    @IBOutlet weak var numberFollowingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = tweet.name
        handleLabel.text = "@\(tweet.screenname!)"
        descriptionLabel.text = tweet.bio
        numberFollowersLabel.text = "Number of Followers: \(tweet.followersCount)"
        numberFollowingLabel.text = "Number of Friends: \(tweet.numberFollowing)"
        numberTweetsLabel.text = "Number of Tweets: \(tweet.numberTweets)"
        profileImageView.setImageWithURL(tweet.profileImageURL!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
