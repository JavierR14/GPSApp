//
//  hostViewController.swift
//  GPSApp
//
//  Created by Charles Bai on 2016-01-24.
//  Copyright © 2016 Charles Bai. All rights reserved.
//

import UIKit

class HostViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var waitingLabel: UILabel!
    @IBOutlet var connectLabel: UILabel!
    @IBOutlet var connectTextField: UITextField!
    @IBOutlet var connectButton: UIButton!
    @IBOutlet var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // tapping on the view calls the dismissKeyboard function and add this gesture to the view
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.connectTextField.delegate = self
        
        self.errorLabel.hidden = true;
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
    
    @IBAction func googleSignOut(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    @IBAction func connect(sender: AnyObject) {
        if (self.connectTextField.text == "anotherone") {
            performSegueWithIdentifier("showMap", sender: sender)
            self.errorLabel.hidden = true
        } else {
            self.errorLabel.hidden = false
        }
    }

    
}
