//
//  ViewController.swift
//  GPSApp
//
//  Created by Charles Bai on 2016-01-23.
//  Copyright © 2016 Charles Bai. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate {
    
    @IBOutlet var inquiryLabel: UILabel!
    @IBOutlet var userField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var goButton: UIButton!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tapping on the view calls the dismissKeyboard function and add this gesture to the view
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        //view.addGestureRecognizer(tap)
        
        self.userField.delegate = self
        
        // hide the errorLabel initially
        self.errorLabel.hidden = true
        
        //set google sign-in delegate
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        //myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
        presentViewController viewController: UIViewController!) {
            self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
        dismissViewController viewController: UIViewController!) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // clicking "done" closes the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    // handles button functionality
    @IBAction func go (sender: AnyObject) {
        // "username" is the only acceptable input for now
        if (userField.text == "username") {
            performSegueWithIdentifier("validUser", sender: sender)
            self.errorLabel.hidden = true
        } else {
            self.errorLabel.hidden = false
        }
    }

}

