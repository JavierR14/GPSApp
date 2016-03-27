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

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.connectTextField.delegate = self
        self.errorLabel.hidden = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func signOut(sender: AnyObject) {
        DownloadManager.sharedInstance.signOut()
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
