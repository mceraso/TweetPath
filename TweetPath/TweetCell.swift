//
//  TweetCell.swift
//  TweetPath
//
//  Created by Michael Ceraso on 2/25/16.
//  Copyright © 2016 Michael Ceraso. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            createdAtLabel.text = tweet.createdAtString
            tweetLabel.text = tweet.text
            usernameLabel.text = tweet.name
            profileImageView.setImageWithURL(tweet.profileImageURL!)

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
