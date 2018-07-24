//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by ngt kn on 7/23/18.
//  Copyright © 2018 ngtkn. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
@IBOutlet weak var label: UILabel!
    
    // Outlets for text fields
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    // Outlets for buttons
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnForgotPass: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // alignment for objects
        label.frame = CGRect(x: 10, y: 80, width: self.view.frame.size.width - 20, height: 50)
        userNameTextField.frame = CGRect(x: 10, y: label.frame.origin.y + 70,
                                         width: self.view.frame.size.width - 20, height: 30)
        passwordTextField.frame = CGRect(x: 10, y: userNameTextField.frame.origin.y + 40,
                                         width: self.view.frame.size.width - 20, height: 30)
        btnForgotPass.frame = CGRect(x: 10, y: passwordTextField.frame.origin.y + 30,
                                     width: self.view.frame.size.width - 20, height: 30)
        btnSignIn.frame = CGRect(x: 20, y: btnForgotPass.frame.origin.y + 40,
                                 width: self.view.frame.size.width / 4, height: 30)
        btnSignUp.frame = CGRect(x: self.view.frame.size.width - (self.view.frame.size.width / 4) - 20,
                                 y: btnSignIn.frame.origin.y, width: self.view.frame.size.width / 4, height: 30)
        
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.hideKeyboardTapped(_:)))
        hideTap.numberOfTapsRequired = 1;
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSignInClick(_ sender: UIButton) {
        print("sign in")
        
        self.view.endEditing(true)
        
        if (userNameTextField.text!.isEmpty || passwordTextField.text!.isEmpty) {
            let alert = UIAlertController(title: "Login Error", message: "Empty field", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        PFUser.logInWithUsername(inBackground: userNameTextField.text!, password: passwordTextField.text!) { (user, error) -> Void in
            if error == nil {
                // save logged in user to memory
                UserDefaults.standard.set(user!.username, forKey: "username")
                UserDefaults.standard.synchronize()
                
                // call login function from AppDelegate
                let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
            }
        }
    }
    
    // hide keyboard if view tapped
    @objc func hideKeyboardTapped(_ recognizer:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
