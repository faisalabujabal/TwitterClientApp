//
//  NewTweetViewController.swift
//  TwitterClientApp
//
//  Created by Faisal Abu Jabal on 2/29/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {
    
    @IBOutlet weak var TweetTextField: UITextField!
    var replyUsername: String? = nil
    var replyTweetID: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(replyUsername != nil){
            TweetTextField.text = replyUsername
        } else {
            TweetTextField.text = ""
        }
        
    }

    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func tweet(sender: AnyObject) {
        if(TweetTextField.text != ""){
            if(replyUsername != nil && replyTweetID != nil){
                TwitterClient.sharedInstance.tweet(replyTweetID!, tweetText: TweetTextField.text!, success: { () -> () in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            } else {
                TwitterClient.sharedInstance.tweet(nil, tweetText: TweetTextField.text!, success: { () -> () in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            }
        }
    }
}




