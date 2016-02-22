//
//  Tweet.swift
//  TwitterClientApp
//
//  Created by Faisal Abu Jabal on 2/21/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var userProfileImageURL: NSURL?
    var userScreenName: NSString?
    var userName: NSString?
    var tweetID: Int = 0
    
    var printed: Bool = false
    
    init(dictionary: NSDictionary){
        
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        tweetID = (dictionary["id"]) as? Int ?? 0
        let profileImageURLString = dictionary["user"]!["profile_image_url_https"] as? String
        if let profileImageURLString = profileImageURLString {
            userProfileImageURL = NSURL(string: profileImageURLString)
        }
        userScreenName = dictionary["user"]!["screen_name"] as? String
        userName = dictionary["user"]!["name"] as? String
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
            print(timestamp)
        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
    
}
