//
//  ChatViewController.swift
//  SpinChat
//
//  Created by Spencer Johnson on 9/28/16.
//  Copyright © 2016 Spencer Johnson. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ConversationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var polls : [YNPoll] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.gray, NSFontAttributeName: UIFont(name: "Proxima Nova", size: 20)!]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        FIRDatabase.database().reference().child("users").child((FIRAuth.auth()!.currentUser)!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let poll = YNPoll()
            let snapshotValue = snapshot.value as? NSDictionary
            
            poll.imageURL = snapshotValue!["imageURL"] as! String
            poll.questionString = snapshotValue!["question"] as! String
            poll.senderUser = snapshotValue!["from"] as! String
            poll.answer1 = snapshotValue!["answer1"] as! String
            poll.answer2 = snapshotValue!["answer2"] as! String
            
            self.polls.append(poll)
           
            self.tableView.reloadData()
            
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return polls.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PollTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PollTableViewCell
        
        let pollCell = polls[indexPath.row]
        
        cell.questionStringTextLabel.text = pollCell.questionString
        cell.senderUserTextLabel.text = pollCell.senderUser
        cell.answer1Button.setTitle(pollCell.answer1, for: UIControlState.normal)
        cell.answer2Button.setTitle(pollCell.answer2, for: UIControlState.normal)
        
        
        return cell
    }
    

    @IBAction func logoutTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    
    }
    
}
