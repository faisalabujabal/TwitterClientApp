//
//  TweetsViewController.swift
//  TwitterClientApp
//
//  Created by Faisal Abu Jabal on 2/21/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]!
    @IBOutlet weak var tweetsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetsTableView.dataSource = self
        tweetsTableView.delegate = self
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 200
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tweetsTableView.reloadData()
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }
    }
    
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }

    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        let currentTweet = tweets[indexPath.row]
//        if currentTweet.userProfileImageURL != nil {
            cell.profileImage.setImageWithURL(currentTweet.userProfileImageURL!)
//        }
        cell.screenNameLabel.text = currentTweet.userName as? String
        cell.usernameLabel.text = "@\(currentTweet.userScreenName as! String)"
//        let dateFormatter = NSDateFormatter()
//        cell.tweetTimestampLabel.text = dateFormatter.stringFromDate(currentTweet.timestamp!)
//        //let oneHourBack = currentTweet.timestamp!.dateWithTimeInterval(-3600)
//        let oneHourBack = NSDate(timeIntervalSinceNow: -3600)
//        print("one hour \(oneHourBack)")
        cell.tweetTextLabel.text = currentTweet.text as? String
        cell.tweetID = currentTweet.tweetID
        cell.retweetButton.setTitle("\(currentTweet.retweetCount) Retweets", forState: .Normal)
        cell.favoriteButton.setTitle("\(currentTweet.favoritesCount) Favorites", forState: .Normal)
        cell.retweetCounter = currentTweet.retweetCount
        cell.favoriteCounter = currentTweet.favoritesCount
        return cell
    }
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if((tweets) != nil){
            return tweets.count
        } else {
            return 0
        }
    }
    
    
    
}
