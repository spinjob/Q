//
//  PollViewController.swift
//  SpinChat
//
//  Created by Spencer Johnson on 10/5/16.
//  Copyright © 2016 Spencer Johnson. All rights reserved.
//

import UIKit
import FirebaseStorage

class PollViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yesTextField: UITextField!
    @IBOutlet weak var noTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
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
    
    @IBAction func nextTapped(_ sender: AnyObject) {
        
        nextButton.isEnabled = false
        
        let imagesFolder = FIRStorage.storage().reference().child("images")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").put(imageData, metadata: nil) { (metadata, error) in
            
            print("We tried to upload")
            if error != nil {
                print("We had an error:\(error)!")
            } else {
                self.performSegue(withIdentifier: "selectFriendsSegue", sender: nil)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
            }
        }


