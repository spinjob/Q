//
//  PollViewController.swift
//  SpinChat
//
//  Created by Spencer Johnson on 10/5/16.
//  Copyright © 2016 Spencer Johnson. All rights reserved.
//

import UIKit

class PollViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yesTextField: UITextField!
    @IBOutlet weak var noTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var activeField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        yesTextField.borderStyle = UITextBorderStyle.roundedRect
        noTextField.borderStyle = UITextBorderStyle.roundedRect
    
        navigationController?.navigationBar.barTintColor = UIColor.white
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    

    @IBAction func nextButtonTapped(_ sender: AnyObject) {
    }
    
    @IBAction func closeIconTapped(_ sender: AnyObject) {
    }

}
