//
//  LoginViewController.swift
//  TwitterClientApp
//
//  Created by Faisal Abu Jabal on 2/21/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }

    @IBAction func onLoginButton(sender: AnyObject) {
        TwitterClient.sharedInstance.login({ () -> () in
            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }
    }
}
