//
//  TweetDetailViewController.swift
//  TwitterClientApp
//
//  Created by Faisal Abu Jabal on 2/28/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var profileImageScreenName: UIButton!
    
    var tweet: Tweet!
    
    var retweetCounter: Int = 0
    var favoriteCounter: Int = 0
    var tweetID: Int = 0
    
    
    override func viewDidLoad() {
        usernameLabel.text = "@\(tweet.userScreenName as! String)"
        nameLabel.text = tweet.userName as? String
        tweetLabel.text = tweet.text as? String
        profileImage.setImageWithURL(tweet.userProfileImageURL!)
        retweetButton.setTitle("\(self.retweetCounter) Retweets", forState: .Normal)
        favoriteButton.setTitle("\(self.favoriteCounter) Favorites", forState: .Normal)
    }
    
    @IBAction func retweet(sender: UIButton) {
        TwitterClient.sharedInstance.retweet(self.tweet.tweetID) { () -> () in
            self.retweetCounter++
            self.retweetButton.setTitle("\(self.retweetCounter) Retweets", forState: .Normal)
        }
    }
    
    
    @IBAction func favorite(sender: UIButton) {
        TwitterClient.sharedInstance.favorite(self.tweet.tweetID) { () -> () in
            self.favoriteCounter++
            self.favoriteButton.setTitle("\(self.favoriteCounter) Favorites", forState: .Normal)
        }
    }
    
    
//    @IBAction func reply(sender: AnyObject) {
//        print("replied")
//    
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.identifier)
        if((segue.identifier) == "ProfileImageSegue"){
            let profileViewController = segue.destinationViewController as! ProfilePageViewController
            let username: String? = tweet.userScreenName as? String
            let coverImageDictionary = TwitterClient.sharedInstance.getProfileBanner(username!)
            if(coverImageDictionary != nil){
                 profileViewController.coverImageURL = coverImageDictionary!["mobile"]?.url
            }
            
            profileViewController.author = tweet.author
            
        } else {
            let replyViewController = segue.destinationViewController as! NewTweetViewController
            replyViewController.replyTweetID = tweet.tweetID
            replyViewController.replyUsername = "@\(tweet.userScreenName as! String)"
        }
    }
    
    
}
