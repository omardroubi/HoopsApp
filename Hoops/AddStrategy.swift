//
//  AddStrategy.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/12/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase

class AddStrategy: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    var planRefwrite = FIRDatabase.database().reference().child("Plans")
    var storageRef = FIRStorage.storage().reference()
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func submit(_ sender: Any) {
        
        if (gameTextField.text == "")
        {
            let alert = UIAlertController(title: "Missing title", message: "Please specify the plan's game", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else if (imageview.image == nil)
        {
            
            let alert = UIAlertController(title: "Missing plan", message: "Please upload the plan's diagram", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        else {
        
            let data = UIImageJPEGRepresentation(self.imageview.image!, 0.8)
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            //let planid = NSUUID().uuidString
            let imagepath = "plan/\(gameTextField.text!)/planimage"
            
            storageRef.child(imagepath).put(data!, metadata: metadata) { (metadata, error) in
                if error == nil {
                    let newplan = strategy(game: self.gameTextField.text! , planurl: String(describing: metadata!.downloadURL()!))
                    
                    
                    let planRefwrite = self.planRefwrite.child(self.gameTextField.text!)
                    
                    planRefwrite.setValue(newplan.toAnyObject())
                    
                    self.self.dismiss(animated: true, completion: nil)
                    
                } else {
                    let alert = UIAlertController(title: "Image error", message: "Please upload a valid image", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
        @IBAction func addImage(_ sender: Any) {
            let image = UIImagePickerController()
            image.delegate = self
            
            image.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            image.allowsEditing = false
            self.present(image, animated : true)
            
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                imageview.image = image
            }
            else {
                let alert = UIAlertController(title: "Image error", message: "Please upload a valid image", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
            dismiss(animated: true, completion: nil)
        }
        @IBOutlet weak var gameTextField: UITextField!
        
        @IBOutlet weak var imageview: UIImageView!
        
        override func viewDidLoad() {
            gameTextField.delegate = self
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)

            // Do any additional setup after loading the view.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            self.view.endEditing(true)
            
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            gameTextField.resignFirstResponder()
            return true
            
        }
        
}
