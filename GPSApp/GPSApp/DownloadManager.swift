//
//  DownloadManager.swift
//  GPSApp
//
//  Created by Charles Bai on 2016-03-08.
//  Copyright © 2016 Charles Bai. All rights reserved.
//

import Foundation
import Alamofire

class DownloadManager {
    static let sharedInstance = DownloadManager()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var headers = ["Content-Type" : "application/json" ,"Authentication-Token": ""]
    var token :String
    
    init () {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("userInfo") as? NSData {
            let userData : NSMutableArray = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! NSMutableArray
            self.token = userData.objectAtIndex(0) as! String
        } else {
            self.token = ""
        }
    }
    
    // Push Google Data to Server and retrieve the token
    func registerUser (dictionary: [String : AnyObject]) {
        let serverUrl : String = "https://gpsapp-master.herokuapp.com/api/signin"
        
        Alamofire.request(.POST, serverUrl, parameters: dictionary, encoding: .JSON).responseJSON {
            response in
            
            if let JSON = response.result.value {
                self.token = (JSON as! NSDictionary)["authtoken"] as! String
                
                let userInfo = NSMutableArray ()
                userInfo.addObject(self.token)
               
                self.saveInfo(userInfo)
            }
        }
    }
    
    func postLocation (var dictionary: [String : AnyObject]) {
        let serverUrl : String = "https://gpsapp-master.herokuapp.com/api/post_location"
        dictionary["auth_token"] = self.token
        Alamofire.request(.POST, serverUrl, parameters: dictionary, encoding: .JSON)
    }
    
    func signOut() {
        self.appDelegate.signOut()
    }
    
    func saveInfo (userInfo : NSMutableArray) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(userInfo)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "userInfo")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func deleteInfo () {
        NSUserDefaults.standardUserDefaults().setObject( nil , forKey: "userInfo")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
