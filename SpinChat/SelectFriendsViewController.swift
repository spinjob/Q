//
//  SelectFriendsViewController.swift
//  SpinChat
//
//  Created by Spencer Johnson on 10/6/16.
//  Copyright © 2016 Spencer Johnson. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SelectFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    

    var users : [User] = []
    var selectedUsers : [String] = []
    var fromUserEmail = ""
    var fromUserName = ""
    var fromUserUID = ""
    
    var imageURL = ""
    var questionString = ""
    var answerString1 = ""
    var answerString2 = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.gray, NSFontAttributeName: UIFont(name: "Proxima Nova", size: 20)!]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.tableView.allowsMultipleSelection = true
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
        let cellIdentifier = "FriendTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FriendTableViewCell
        
        let friendCell = users[indexPath.row]
        cell.friendNameTextLabel.text = friendCell.email
        
        let image = UIImage(named: "profileSocialSmall45.png")
        cell.friendProfileImageView.image = image
        cell.friendProfileImageView.layer.cornerRadius = (image?.size.width)!/2
        cell.friendProfileImageView.layer.masksToBounds = true
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        selectedUsers.append(user.uid)
        print(selectedUsers)
       
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        selectedUsers = selectedUsers.filter {$0 != user.uid}
        print(selectedUsers)
    }
    
    
    @IBAction func nextButtonTapped(_ sender: AnyObject) {
        
        let n0 = selectedUsers.count
        let n = (n0 - 1)
        
        let stringRepresentation = selectedUsers.joined(separator: ",")
        
        let poll = ["from": fromUserEmail, "question": questionString, "imageURL":imageURL, "answer1": answerString1, "answer2":answerString2, "to": stringRepresentation]

        for i in 0..<n0 {
            FIRDatabase.database().reference().child("users").child(selectedUsers.first!).child("snaps").childByAutoId().setValue(poll)
            
            selectedUsers.removeFirst()
        }

    
    }
}
