//
//  TweetCell.swift
//  TwitterClientApp
//
//  Created by Faisal Abu Jabal on 2/22/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageScreenName: UIButton!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTimestampLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var retweetCounter: Int = 0
    var favoriteCounter: Int = 0
    var tweetID: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
    }
    
    
    @IBAction func retweet(sender: UIButton) {
//        print(self.tweetID)
        TwitterClient.sharedInstance.retweet(self.tweetID) { () -> () in
            self.retweetCounter++
            self.retweetButton.setTitle("\(self.retweetCounter) Retweets", forState: .Normal)
        }
    }
    

    @IBAction func favorite(sender: UIButton) {
        TwitterClient.sharedInstance.favorite(self.tweetID) { () -> () in
            self.favoriteCounter++
            self.favoriteButton.setTitle("\(self.favoriteCounter) Favorites", forState: .Normal)
        }
    }
    
}
