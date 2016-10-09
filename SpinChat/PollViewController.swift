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
    @IBOutlet weak var cameraIcon: UIButton!
    
    
    var imagePicker = UIImagePickerController()
    var activeField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if imageView.isHidden == false {
            moveTextFields()
        } else {
        
        }
        
        imagePicker.delegate = self
        
        imageView.isHidden = true
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.cornerRadius = 4
        
        questionTextField.sizeToFit()
        
        yesTextField.borderStyle = UITextBorderStyle.roundedRect
        noTextField.borderStyle = UITextBorderStyle.roundedRect
    
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.gray, NSFontAttributeName: UIFont(name: "Proxima Nova", size: 20)!]
        navigationController?.navigationBar.backItem?.backBarButtonItem!.title = "X"
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        [questionTextField .becomeFirstResponder()];
    }
    
    override func viewDidLayoutSubviews() {
        if imageView.isHidden == false {
            moveTextFields()
        } else {
            
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        imageView.isHidden = false
        
        imagePicker.dismiss(animated: true, completion: moveTextFields)
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
               
                print(metadata?.downloadURL())
                
            } else {
                self.performSegue(withIdentifier: "selectFriendsSegue", sender: metadata?.downloadURL()!.absoluteString)
            }
        }
        
    }
    
    func moveTextFields () {
        
        yesTextField.frame.origin = CGPoint(x: 37, y: 510)
        noTextField.frame.origin = CGPoint(x: 220, y: 510)
        questionTextField.frame.origin = CGPoint(x: 37, y: 460)
        cameraIcon.frame.origin = CGPoint(x: 338, y: 395)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! SelectFriendsViewController
        nextViewController.imageURL = sender as! String
        nextViewController.questionString = questionTextField.text!
            }
        }


