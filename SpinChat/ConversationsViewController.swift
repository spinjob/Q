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
    
    var answerDictionary = ["answer 1": ["user1", "user2", "user3"]]

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
            poll.recipientUserIDString = snapshotValue!["to"] as! String
            
            self.polls.append(poll)
           
            self.tableView.reloadData()
            
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return polls.count

    }
    

    func answer1Selected (sender:UIButton!) {
        sender.isUserInteractionEnabled = false
        
        print(answerDictionary[sender.currentTitle!]?.count)
        
        //let answerPercentageInt = (((answerDictionary[sender.currentTitle!]?.count)! / answerDictionary.count)*100)
        //let answerPercentageFloat = Float(answerPercentageInt)
        view.frame.origin.x += 10
        
        //view.frame.size = CGSize(width: answerPercentageInt, height: 39)
        
        let buttonTag = sender.tag
        print(sender.currentTitle)
        answerDictionary[sender.currentTitle!]?.append("\(FIRAuth.auth()?.currentUser?.email)")
        FIRDatabase.database().reference().child("polls").childByAutoId().child("recipients").child((FIRAuth.auth()?.currentUser?.uid)!).child("answer").setValue(sender.currentTitle!)
        
        //sender.setTitle("\(answerPercentageInt)", for: .normal)
        sender.setTitle("&", for: .normal)
        UIView.animate(withDuration: 0.5, animations: {
        sender.transform = CGAffineTransform(scaleX: 1.2,y: 1)
            
    
        })
    }
    func answer2Selected (sender: UIButton!) {
        let buttonTag = sender.tag
        print(sender.currentTitle)
        answerDictionary[sender.currentTitle!]?.append((FIRAuth.auth()?.currentUser?.email)!)
        FIRDatabase.database().reference().child("polls").childByAutoId().child("recipients").child((FIRAuth.auth()?.currentUser?.uid)!).child("answer").setValue(sender.currentTitle!)
        
        sender.setTitle("%", for: .normal)
        
        UIView.animate(withDuration: 0.5, animations: {
            sender.transform = CGAffineTransform(scaleX: 1.2,y: 1)
        })
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PollTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PollTableViewCell
        
        let pollCell = polls[indexPath.row]
        
        cell.questionStringTextLabel.text = pollCell.questionString
        cell.senderUserTextLabel.text = pollCell.senderUser
        cell.answer1Button.setTitle(pollCell.answer1, for: UIControlState.normal)
        cell.answer2Button.setTitle(pollCell.answer2, for: UIControlState.normal)
        cell.answer1Button.addTarget(self, action: #selector(ConversationsViewController().answer1Selected(sender:)), for: .touchUpInside)
        cell.answer2Button.addTarget(self, action: #selector(ConversationsViewController().answer2Selected(sender:)), for: .touchUpInside)
        
        
        
        
        //Function to loop through the array of userID strings...query for the "name" of the user with that uid...pull out the "name" value and add it to the userNameListArray
        let recipientUserIDListString = pollCell.recipientUserIDString
        var recipientUserIDListArray = recipientUserIDListString.components(separatedBy: ",")
        var recipientUserNameListArray : [String] = []
        
        func transformUserIDArrayToUserNameArray ( uIDListArray: [String]) -> [String] {
            
            let n = uIDListArray.count
           
            
            for i in 0..<n {
                FIRDatabase.database().reference().child("users").child(uIDListArray.first!).child("name").observe(FIRDataEventType.value, with: {(snapshot) in
                    
                    let snapshotValue = snapshot.value as! String
                    let recipientUserNameString = snapshotValue
                    recipientUserIDListArray.append(recipientUserNameString)
                    
                })
                
                recipientUserIDListArray.removeFirst()
                
            }
            return recipientUserIDListArray
        }
    
        
        //NEED TO FIGURE OUT HOW TO MUTATE THE ACTUAL RECIPIENT USERIDLISTARRAY RATHER THAN JUST MUTATING THE COPY WITHIN THE FUNCTION
        
        //THAT'S WHY THE STATEMENT BELOW DOES NOT WORK
        cell.recipientUserTextLabel.text = transformUserIDArrayToUserNameArray(uIDListArray: recipientUserIDListArray).joined(separator: ",")

        print(transformUserIDArrayToUserNameArray(uIDListArray: recipientUserIDListArray))
        
        
        let image = UIImage(named: "profileSocialSmall45.png")
        cell.senderUserProfileImageView.image = image
        cell.senderUserProfileImageView.layer.cornerRadius = (image?.size.width)!/2
        cell.senderUserProfileImageView.layer.masksToBounds = true
        
        
        return cell
    }


    @IBAction func answer1Tapped(_ sender: AnyObject) {
       

        

    }
    
    @IBAction func logoutTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    
        }
  
    
}
