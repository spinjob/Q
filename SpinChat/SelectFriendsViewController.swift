//
//  SelectFriendsViewController.swift
//  SpinChat
//
//  Created by Spencer Johnson on 10/6/16.
//  Copyright © 2016 Spencer Johnson. All rights reserved.
//

import UIKit

class SelectFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
