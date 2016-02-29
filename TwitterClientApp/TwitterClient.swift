//
//  TwitterClient.swift
//  TwitterClientApp
//
//  Created by Faisal Abu Jabal on 2/21/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "thhF0oeoJSPIO15pADlI3kvlT", consumerSecret: "Q3QHzbdaJPojImdFTRZEqHDRK9Q5lx4ohn9XIzbUOAhhMzPAG1")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func login(success: ()->(), failure: (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterclientapp://oauth"), scope: nil, success: { (requestToken:
            BDBOAuth1Credential!) -> Void in
                let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
                UIApplication.sharedApplication().openURL(url)
        }) {(error:NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToek: BDBOAuth1Credential!) -> Void in
            
                self.currentAccount({ (user: User) -> () in
                    User.currentUser = user
                    self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                        self.loginFailure?(error)
                })
            
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
    
    func getUserFromScreenName(screenName: String?) -> User? {
        var retUser: User?
        GET("1.1/users/lookup.json?screen_name=\(screenName)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! [NSDictionary]
            let user = User(dictionary: userDictionary[0])
            retUser = user
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
                retUser = nil
        })
        return retUser
    }
    
    func retweet(tweetID: Int, success: () -> ()){
        POST("1.1/statuses/retweet/\(tweetID).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("retweeted")
            success()
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
        }
    }
    
    func favorite(tweetID: Int, success: () -> ()){
        POST("1.1/favorites/create.json?id=\(tweetID)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("favorited")
            success()
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
        }
    }
    
    func tweet(tweetID: Int?, tweetText: String, success: () -> ()){
        let tweetTextURLEncoded = tweetText.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        var url = "1.1/statuses/update.json?status=\(tweetTextURLEncoded!)"
        if(tweetID != nil){
            url += "&in_reply_to_status_id=\(tweetID)"
        }
        POST(url, parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("favorited")
            success()
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
        }
    }
    
    func getProfileBanner(screenName: String) -> NSDictionary? {
        var profileBanner: NSDictionary?
        GET("1.1/users/profile_banner.json?screen_name=\(screenName)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let userDictionary = response as! NSDictionary
                profileBanner = userDictionary
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
                profileBanner = nil
        })
        return profileBanner
    }
    
}
