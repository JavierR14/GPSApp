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
    var userImage : UIImage
    
    init () {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("userInfo") as? NSData {
            let userData : NSMutableArray = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! NSMutableArray
            self.token = userData.objectAtIndex(0) as! String
        } else {
            self.token = ""
        }
        userImage = UIImage()
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
    
    func getUserImage (imageUrl: String) {
        Alamofire.request(.GET, imageUrl).response() {
            (_, _, data, _) in
            self.userImage = UIImage(data: data!)!
        }
    }
    
    func getETA (var dictionary: [String : AnyObject]) {
        //https://developers.google.com/maps/documentation/distance-matrix/intro#Audience
        dictionary["key"] = "AIzaSyD74jnAmeyuB_uAYvTJLAi3Du7Ygku-urU"
        let serverUrl : String = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=\(dictionary["origins"])&destinations=\(dictionary["destinations"])&key=AIzaSyCIftUB6bTESOT82zyCBcMd02lK4mY-6D4"
        Alamofire.request(.GET, serverUrl, parameters: nil, encoding: .JSON).responseString {
            response in
            print(response)
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
        
        self.appDelegate.showHostScreen()
    }
    
    func deleteInfo () {
        NSUserDefaults.standardUserDefaults().setObject( nil , forKey: "userInfo")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
