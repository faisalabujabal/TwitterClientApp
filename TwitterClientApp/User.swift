//
//  User.swift
//  TwitterClientApp
//
//  Created by Faisal Abu Jabal on 2/21/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: NSString?
    var screenName: NSString?
    var profileURL: NSURL?
    var tagline: NSString?
    var profileImageURL: NSURL?
    var followersCounter: NSString?
    var followingCounter: NSString?
    var favoritesCounter: NSString?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileImageURLString = dictionary["profile_image_url_https"] as? String
        if let profileImageURLString = profileImageURLString {
            profileImageURL = NSURL(string: profileImageURLString)
        }
        
        print(dictionary)
        
        tagline = dictionary["description"] as? String
        followersCounter = dictionary["followers_count"] as? String
        followingCounter = dictionary["friends_count"] as? String
    }
    static let userDidLogoutNotification = "UserDidLogout"
    static var _currentUser: User?
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
        
                if let userData = userData {
                    let dictionary = try!
                        NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
    
}
