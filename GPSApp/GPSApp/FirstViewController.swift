//
//  ViewController.swift
//  GPSApp
//
//  Created by Charles Bai on 2016-01-23.
//  Copyright © 2016 Charles Bai. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var inquiryLabel: UILabel!
    @IBOutlet var userField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tapping on the view calls the dismissKeyboard function and add this gesture to the view
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.userField.delegate = self
        
        // hide the errorLabel initially
        self.errorLabel.hidden = true
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

