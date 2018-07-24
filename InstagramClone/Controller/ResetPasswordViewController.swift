//
//  ResetPasswordViewController.swift
//  InstagramClone
//
//  Created by ngt kn on 7/23/18.
//  Copyright © 2018 ngtkn. All rights reserved.
//

import UIKit
import Parse

class ResetPasswordViewController: UIViewController {
    // textfield
    @IBOutlet weak var emailText: UITextField!
    
    // buttons
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // alignments
        emailText.frame = CGRect(x: 10, y: 120, width: self.view.frame.size.width - 20, height: 30)
        btnReset.frame = CGRect(x: 20, y: emailText.frame.origin.y + 50,
                                width: self.view.frame.size.width / 4, height: 30)
        btnCancel.frame = CGRect(x: self.view.frame.size.width - (self.view.frame.size.width / 4) - 20 ,
                                 y: btnReset.frame.origin.y, width: self.view.frame.size.width / 4, height: 30)
    }
    // Currently not supported by heroku
    @IBAction func btnResetClicked(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if emailText.text!.isEmpty {
            let alert = UIAlertController(title: "Error", message: "email field is empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        // request for reseting password
        PFUser.requestPasswordResetForEmail(inBackground: emailText.text!) { (success, error) -> Void in
            if success {
                // show alert success
                let alert = UIAlertController(title: "Email for reseting password", message: "has been sent to texted email", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
                    self.dismiss(animated: true, completion: nil)
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    // hide keyboard/ dismiss view
    @IBAction func btnCancelClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
}
