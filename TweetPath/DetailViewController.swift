//
//  DetailViewController.swift
//  TweetPath
//
//  Created by Michael Ceraso on 2/27/16.
//  Copyright © 2016 Michael Ceraso. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var tweet: Tweet!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = tweet.name
        handleLabel.text = "@\(tweet.screenname!)"
        createdAtLabel.text = tweet.createdAtString
        tweetTextLabel.text = tweet.text
        profileImageView.setImageWithURL(tweet.profileImageURL!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onProfile(sender: AnyObject) {
        performSegueWithIdentifier("ProfileViewSegue", sender: nil)
        
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
