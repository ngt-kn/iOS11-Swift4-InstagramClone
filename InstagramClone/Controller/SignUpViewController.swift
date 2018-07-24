//
//  SignUpViewController.swift
//  InstagramClone
//
//  Created by ngt kn on 7/23/18.
//  Copyright © 2018 ngtkn. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Profile image outlet
    @IBOutlet weak var profileImageView: UIImageView!
    // textfield outlets
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var repeatPasswordText: UITextField!
    @IBOutlet weak var fullNameText: UITextField!
    @IBOutlet weak var bioText: UITextField!
    @IBOutlet weak var websiteText: UITextField!
    // scrollview outlet
    @IBOutlet weak var scrollView: UIScrollView!
    // button outlets
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    
    // Reset scrollview  default size
    var scrollViewHeight: CGFloat = 0;
    // keyboard frame size
    var keyboardFrameSize = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        scrollView.contentSize.height = self.view.frame.height
        scrollViewHeight = scrollView.frame.size.height;
        
        // check notification center if keyboard is shown or not
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.showKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // init hide keybard tap recognizer
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.hideKeyboardTapped(_:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
        
        // change to round image view
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true
        
        // profile image tap recognizer
        let profileImageTap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.loadImg(_:)))
        profileImageTap .numberOfTapsRequired = 1
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(profileImageTap)
        
        // alignment
        profileImageView.frame = CGRect(x: self.view.frame.size.width / 2 - 40, y: 40, width: 80, height: 80)
        emailText.frame = CGRect(x: 10, y: profileImageView.frame.origin.y + 90,
                                 width: self.view.frame.size.width - 20, height: 30)
        userNameText.frame = CGRect(x: 10, y: emailText.frame.origin.y + 40,
                                    width: self.view.frame.size.width - 20, height: 30)
        passwordText.frame = CGRect(x: 10, y: userNameText.frame.origin.y + 40,
                                    width: self.view.frame.size.width - 20, height: 30)
        repeatPasswordText.frame = CGRect(x: 10, y: passwordText.frame.origin.y + 40,
                                          width: self.view.frame.size.width - 20, height: 30)
        fullNameText.frame = CGRect(x: 10, y: repeatPasswordText.frame.origin.y + 60,
                                    width: self.view.frame.size.width - 20, height: 30)
        bioText.frame = CGRect(x: 10, y: fullNameText.frame.origin.y + 40,
                               width: self.view.frame.size.width - 20, height: 30)
        websiteText.frame = CGRect(x: 10, y: bioText.frame.origin.y + 40,
                                   width: self.view.frame.size.width - 20, height: 30)
        
        btnSignUp.frame = CGRect(x: 20, y: websiteText.frame.origin.y + 50,
                                 width: self.view.frame.size.width / 4, height: 30)
        btnCancel.frame = CGRect(x: self.view.frame.size.width - (self.view.frame.size.width / 4) - 20, y: btnSignUp.frame.origin.y, width: self.view.frame.size.width / 4 - 20, height: 30)
    }
    
    // show keyboard func, move scrollview up
    @objc func showKeyboard(_ notification:NSNotification) {
        // define keyboard size
        keyboardFrameSize = ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue)!

        // move up UI
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.scrollView.frame.size.height = self.scrollViewHeight - self.keyboardFrameSize.height
        })
    }
    
    // hide keyboard func, move scrollview down
    @objc func hideKeyboard(_ notification:Notification) {
        // move down UI
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.scrollView.frame.size.height = self.view.frame.height
        })
    }
    
    // hide keyboard if tapped
    @objc func hideKeyboardTapped(_ recognizer:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // call picker to select image
    @objc func loadImg(_ recognizer:UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    // load selected image into image view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        profileImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // sign up clicked
    @IBAction func btnSignUpClick(_ sender: UIButton) {
        self.view.endEditing(true) // dismiss keyboard
        
        // check if fields are empty
        if (userNameText.text!.isEmpty || emailText.text!.isEmpty || passwordText.text!.isEmpty || fullNameText.text!.isEmpty || bioText.text!.isEmpty || websiteText.text!.isEmpty){
            let alert = UIAlertController(title: "Sign Up Error", message: "Enter All Fields", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        // check if passwords match
        if passwordText.text != repeatPasswordText.text {
            let alert = UIAlertController(title: "Passwords Do Not Match", message: "Enter passwords", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        // Parse send data to server
        let user = PFUser()
        user.username = userNameText.text?.lowercased()
        user.email = emailText.text?.lowercased()
        user.password = passwordText.text
        user["fullname"] = fullNameText.text?.lowercased()
        user["bio"] = bioText.text
        user["website"] = websiteText.text?.lowercased()
        // set up fields for later use in profile
        user["tel"] = ""
        user["gender"] = ""
        
        // profile picture compress then send
        let profileImageData = UIImageJPEGRepresentation(profileImageView.image!, 0.5)
        let profileFile = PFFile(name: "profile.jpg", data: profileImageData!)
        user["profile"] = profileFile
        
        // save data in server
        user.signUpInBackground { (success, error) -> Void in
            if success {
                print("registered")
                
                // Remember username
                UserDefaults.standard.set(user.username, forKey: "username")
                UserDefaults.standard.synchronize()
                
                // call login func from Appdelegate to show main page
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
                
            } else {
                print(error?.localizedDescription ?? "error")
            }
        }
   
    }
    
    // cancel clicked, hide keyboard and dismiss view
    @IBAction func btnCancelClick(_ sender: UIButton) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
}
