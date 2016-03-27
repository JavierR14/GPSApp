//
//  AppDelegate.swift
//  GPSApp
//
//  Created by Charles Bai on 2016-01-23.
//  Copyright © 2016 Charles Bai. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //Google MAPS API
        GMSServices.provideAPIKey("AIzaSyCeUbLHWh4KwOBbPn9Jfp5FLJHxqRkcnrU")
        
        if (DownloadManager.sharedInstance.token == "") {
            showLogin()
        }
        
        setUpGoogleSignIn()
        
        return true
    }
    
    func application(app: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        //pass all info along to google sign-in handleURL method
        return GIDSignIn.sharedInstance().handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                let google_id = user.userID
                let name = user.profile.name
                let email = user.profile.email
                let imageURL = user.profile.imageURLWithDimension(150)
                let image = imageURL.absoluteString
                NSNotificationCenter.defaultCenter().postNotificationName(
                    "ToggleAuthUINotification",
                    object: nil,
                    userInfo: ["name": name,
                        "image": image,
                        "email": email,
                        "google_id": google_id
                    ])
            } else {
                print("\(error.localizedDescription)")
                NSNotificationCenter.defaultCenter().postNotificationName(
                    "ToggleAuthUINotification", object: nil, userInfo: nil)
            }
    }
    
    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }

    func setUpGoogleSignIn() {
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func signOut() {
        GIDSignIn.sharedInstance().signOut()
        DownloadManager.sharedInstance.deleteInfo()
        
        showLogin()
    }
    
    func showHostScreen () {
        let HostViewController : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("NavViewController") as UIViewController
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = HostViewController
        self.window?.makeKeyAndVisible()
    }

    func showLogin(){
        let LoginViewController : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LoginViewController") as UIViewController
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = LoginViewController
        self.window?.makeKeyAndVisible()
    }
}

