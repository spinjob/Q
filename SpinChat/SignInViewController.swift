//
//  SignInViewController.swift
//  SpinChat
//
//  Created by Spencer Johnson on 9/28/16.
//  Copyright © 2016 Spencer Johnson. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextFieldVerticalConstraint: NSLayoutConstraint!

    @IBOutlet weak var loginButtonVerticalConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var signUpButtonVerticalConstraint: NSLayoutConstraint!
    var userName = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.isHidden = true
        emailTextFieldVerticalConstraint.constant = 0

       
    }

    @IBAction func spinItTapped(_ sender: AnyObject) {
        if userNameTextField.isHidden == true {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print ("We are tried to sign in")
            
            if error != nil {
                
                print("We have an error: \(error)")
                } else {
                print("We've signed in successfully")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        })
        }
    }
    

    @IBAction func signUpTapped(_ sender: AnyObject) {
        
        if userNameTextField.isHidden == false {
            FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                print("We tried to create a user:")
                if error != nil {
                    print("We have an error: \(error)")
                } else {
                    print("Created user successfully")
                    
                    FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                    
                    FIRDatabase.database().reference().child("users").child(user!.uid).child("name").setValue(self.userNameTextField.text!)
                    
                    self.performSegue(withIdentifier: "signInSegue", sender: nil)
                }
            })

        } else {
            
            UIView.animate(withDuration: 1.0, animations: {
            self.userNameTextField.isHidden = false
            self.emailTextFieldVerticalConstraint.constant = 21
            self.loginButtonVerticalConstraint.constant = 202
            self.loginButton.titleLabel?.font = UIFont(name: "ProximaNovaSoft-Semibold", size: 21)
            self.signUpButtonVerticalConstraint.constant = 133
            self.signUpButton.titleLabel?.font = UIFont(name: "ProximaNovaSoft-Semibold", size: 27)
        })}
        
        
    }
    
}
