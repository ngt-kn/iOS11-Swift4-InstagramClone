//
//  SignUpViewController.swift
//  InstagramClone
//
//  Created by ngt kn on 7/23/18.
//  Copyright © 2018 ngtkn. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    // Profile image outlet
    @IBOutlet weak var profileImageView: UIImageView!
    // textfield outlets
    @IBOutlet weak var userNameText: UITextField!
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

        // Do any additional setup after loading the view.
    }
    
    // sign up clicked
    @IBAction func btnSignUpClick(_ sender: UIButton) {
        print("sign up pressed")
    }
    
    // cancel clicked
    @IBAction func btnCancelClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
