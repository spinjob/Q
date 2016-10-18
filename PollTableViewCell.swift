//
//  PollTableViewCell.swift
//  SpinChat
//
//  Created by Spencer Johnson on 10/10/16.
//  Copyright © 2016 Spencer Johnson. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class PollTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var questionStringTextLabel: UILabel!
    @IBOutlet weak var senderUserTextLabel: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var senderUserProfileImageView: UIImageView!
    @IBOutlet weak var recipientUserTextLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        answer1Button.layer.cornerRadius = 3.5
        answer2Button.layer.cornerRadius = 3.5
        answer1Button.layer.borderColor = UIColor.init(red: 0, green: 209, blue: 213, alpha: 1).cgColor
        answer1Button.layer.borderWidth = 0.2
        answer2Button.layer.borderColor = UIColor.init(red: 0, green: 209, blue: 213, alpha: 1).cgColor
        answer2Button.layer.borderWidth = 0.2
        

        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       

    }

}
