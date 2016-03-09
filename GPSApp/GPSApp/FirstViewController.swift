//
//  ViewController.swift
//  GPSApp
//
//  Created by Charles Bai on 2016-01-23.
//  Copyright © 2016 Charles Bai. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController, GIDSignInUIDelegate {
    
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
                
                var google_parameters = [String: String?] ()
                google_parameters = [
                    "name": userInfo["name"] as? String,
                    "image": userInfo["image"] as? String,
                    "email": userInfo["email"] as? String,
                    "google_id": userInfo["google_id"] as? String
                ]
                
                //print(parameters["name"]!! + " " + parameters["image"]!! + " " + parameters["email"]!! + " " + parameters["google_id"]!!)
                let parameters = [
                    "email" : google_parameters["email"]!!,
                    "first_name": google_parameters["name"]!!,
                    "last_name": google_parameters["name"]!!
                ]
                
                Alamofire.request(.POST, "gpsapp-master.herokuapp.com/api/signin", parameters: parameters)
                    .responseJSON { response in
                        debugPrint(response)
                    }
            
                performSegueWithIdentifier("showHost", sender: nil)
            }
        }
    }
}

