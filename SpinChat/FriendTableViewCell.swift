//
//  FriendTableViewCell.swift
//  SpinChat
//
//  Created by Spencer Johnson on 10/11/16.
//  Copyright © 2016 Spencer Johnson. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    
    @IBOutlet weak var friendProfileImageView: UIImageView!
    @IBOutlet weak var friendNameTextLabel: UILabel!
    @IBOutlet weak var friendNotSelectedIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
