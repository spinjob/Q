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

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func spinItTapped(_ sender: AnyObject) {
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print ("We are tried to sign in")
            
            if error != nil {
                
                print("We have an error: \(error)")
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user:")
                    if error != nil {
                        print("We have an error: \(error)")
                    } else {
                        print("Created user successfully")
                        
                       FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email!)
                    
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                })
            } else {
                print("We've signed in successfully")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        })
    }


}
