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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
    
    @IBAction func btnCancelClicked(_ sender: UIButton) {
    }
    
}
