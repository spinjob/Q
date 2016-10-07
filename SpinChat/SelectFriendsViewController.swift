//
//  SelectFriendsViewController.swift
//  SpinChat
//
//  Created by Spencer Johnson on 10/6/16.
//  Copyright © 2016 Spencer Johnson. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SelectFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    

    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            
            let user = User()
            let snapshotValue = snapshot.value as? NSDictionary
            user.email = snapshotValue!["email"] as! String
            
            user.uid = snapshot.key
            
            
            self.users.append(user)
            
           self.tableView.reloadData()
            
        })
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    
}
