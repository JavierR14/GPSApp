//
//  ViewController.swift
//  GPSApp
//
//  Created by Charles Bai on 2016-01-23.
//  Copyright © 2016 Charles Bai. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "receiveToggleAuthUINotification:",
            name: "ToggleAuthUINotification",
            object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func receiveToggleAuthUINotification(notification: NSNotification) {
        if (notification.name == "ToggleAuthUINotification") {
            if notification.userInfo != nil {
                
                let userInfo:Dictionary<String,AnyObject!> =
                notification.userInfo as! Dictionary<String,AnyObject!>
                
                var parameters = [String: AnyObject]? ()
                parameters = [
                    "name": userInfo["name"]!,
                    "image": userInfo["image"]!,
                    "email": userInfo["email"]!,
                    "google_id": userInfo["google_id"]!
                ]
                
                DownloadManager.sharedInstance.registerUser(parameters!)
                

                //performSegueWithIdentifier("showHost", sender: nil)
            }
        }
    }
}

