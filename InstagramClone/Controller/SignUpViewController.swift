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
        }
        // check if passwords match
        if passwordText.text != repeatPasswordText.text {
            let alert = UIAlertController(title: "Passwords Do Not Match", message: "Enter passwords", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    // cancel clicked
    @IBAction func btnCancelClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
