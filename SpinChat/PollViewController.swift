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
    

    
    //UI Outlets
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var yesTextField: UITextField!
    @IBOutlet weak var noTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cameraIcon: UIButton!
    @IBOutlet weak var yesButtonVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var yesButtonHorizontalConstraint: NSLayoutConstraint!
    @IBOutlet weak var noButtonHorizontalConstraint: NSLayoutConstraint!
    @IBOutlet weak var noButtonVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionTextVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionTextHorizontalConstraint: NSLayoutConstraint!
    @IBOutlet weak var cameraIconVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var cameraIconHorizontalConstraint: NSLayoutConstraint!
    
    var imagePicker = UIImagePickerController()
    var activeField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Image Picker Delegate
        
        imagePicker.delegate = self
        
        
        //Image View Design
        
        imageView.isHidden = true
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.layer.cornerRadius = 4
        
        
        //Text Field Design
        questionTextField.sizeToFit()
        
        yesTextField.borderStyle = UITextBorderStyle.roundedRect
        noTextField.borderStyle = UITextBorderStyle.roundedRect

        
        //Navigation Bar Design
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.gray, NSFontAttributeName: UIFont(name: "Proxima Nova", size: 20)!]
        navigationController?.navigationBar.backItem?.backBarButtonItem!.title = "X"
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //Picker View Design
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        [questionTextField .becomeFirstResponder()];
    }
    


    //When the image is edited and chosen
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        imageView.isHidden = false
        
        imagePicker.dismiss(animated: true, completion: moveTextFields)
        
        
    }
    
    @IBAction func cameraTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .savedPhotosAlbum
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
    
    //Adjusting Text Field positions when the image view is displayed
    
    func moveTextFields () {
        
        if imageView.isHidden == true {
            print("No image view")
        } else {
            yesButtonVerticalConstraint.constant = 420
            noButtonVerticalConstraint.constant = 420
            yesButtonHorizontalConstraint.constant = 15
            noButtonHorizontalConstraint.constant = 15
            questionTextVerticalConstraint.constant = 375
            questionTextHorizontalConstraint.constant = 16
        }
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! SelectFriendsViewController
        nextViewController.imageURL = sender as! String
        nextViewController.questionString = questionTextField.text!
        nextViewController.answerString1 = yesTextField.text!
        nextViewController.answerString2 = noTextField.text!
        
            }
        }


