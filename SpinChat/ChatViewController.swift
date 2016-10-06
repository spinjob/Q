//
//  ChatViewController.swift
//  SpinChat
//
//  Created by Spencer Johnson on 9/28/16.
//  Copyright © 2016 Spencer Johnson. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    
    }
}
