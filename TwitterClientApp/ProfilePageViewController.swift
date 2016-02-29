//
//  ProfilePageViewController.swift
//  TwitterClientApp
//
//  Created by Faisal Abu Jabal on 2/29/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit

class ProfilePageViewController: UIViewController {
    
    
    @IBOutlet weak var profileBannerImage: UIImageView!
    
    @IBOutlet weak var followingCounter: UILabel!
    @IBOutlet weak var followersCounter: UILabel!
    @IBOutlet weak var tweetsCounter: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var profileImage: UIImageView!
    
    var coverImageURL: NSURL?
    var author: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(coverImageURL != nil){
            profileBannerImage.setImageWithURL(coverImageURL!)
        }
        
        nameLabel.text = author?.name as? String
        usernameLabel.text = author?.screenName as? String
        profileImage.setImageWithURL((author?.profileImageURL)!)
        followersCounter.text = author?.followersCounter as? String
        followingCounter.text = author?.followingCounter as? String
        
    }
    
}
