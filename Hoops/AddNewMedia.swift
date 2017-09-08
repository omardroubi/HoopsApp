//
//  AddNewMedia.swift
//
//

//  Created by Vanessa Nader and Omar Droubi
//  EECE 430 American University of Beirut
//  HOOPS APP

import UIKit
import Firebase //database


// This class is used to add media to the media gallery by the manager
class AddNewMedia: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField! // name of file
    @IBOutlet weak var imageselected: UIImageView! // image of image selected
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self //setup the scenery before the app is used
        // Do any additional setup after loading the view.
    }
    
    
    
    // read from DATABASE
    
    // read for media
    var mediaRefwrite = FIRDatabase.database().reference().child("Media") //access the Media table in the database
    var storageRef = FIRStorage.storage().reference() //create a reference for storage that we will use later
    
    // CANCEL button
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated:true, completion: nil) //dismiss the current scene and go back to the media gallery
    }
    
    // UPLOAD button
    @IBAction func upload(_ sender: Any) {
        
        
        // CHECKERS 
        // CHECK FIELDS are correctly inputted
        
        if (nameTextField.text == "") //check if the filename textfield is empty and create an alert to tell the user the he should imput some text
        {
            let alert = UIAlertController(title: "Missing title", message: "Please specify the filename", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else if (imageselected.image == nil)//check if the user uploaded an image and alert him if he didn't
        {
            
            let alert = UIAlertController(title: "Missing image", message: "Please upload an image", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
            
        // Fields are correct, proceed with solving
        else {
            
            let data = UIImageJPEGRepresentation(self.imageselected.image!, 0.8) //compress the image to a 0.8 quality to be able to upload it to the database
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"  //create a metadata to create a URL later on
            let imagepath = "media/\(nameTextField.text!)/mediaimage" //create an imagepath in the storage so that we can access it later
            
            storageRef.child(imagepath).put(data!, metadata: metadata) { (metadata, error) in
                if error == nil { // if there is no error we can proceed
                    let newmedia = mediafile(filename: self.nameTextField.text! , mediaurl: String(describing: metadata!.downloadURL()!)) //create a new media object with the user inputs
                    
                    
                    let mediaRefwrite = self.mediaRefwrite.child(self.nameTextField.text!) //set a path in the database for this new object
                    
                    mediaRefwrite.setValue(newmedia.toAnyObject()) //convert the object to a dictionary entry to be able to store it in the database
                    
                    self.self.dismiss(animated: true, completion: nil) //go back to the media gallery
                    
                } else { //if there is an error display an alert for the user and don't upload whatever he inserted
                    let alert = UIAlertController(title: "Image error", message: "Please upload a valid image", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil) //dismiss the alert
                }
            }
        }
        
           }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func browse(_ sender: Any) {
        let imagepicker = UIImagePickerController() //create an imagepickercontroller object that will let us access the user's photo library
        imagepicker.allowsEditing = true //allow the picker to make changes
        imagepicker.delegate = self //allow the class to control the picker's behavior

        
        present(imagepicker, animated: true, completion: nil) //present it visually to the user
        
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage { //try to see if the format of the image uploaded is suitable
            imageselected.image = image // if it is we display it to the user in the image view on the screen
        }
        else { //if the format is wrong we alert the user to input a valid picture
            let alert = UIAlertController(title: "Image error", message: "Please upload a valid image", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true) //enable touches outside the textfield by the user to dismiss the keyboard
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameTextField.resignFirstResponder() //enable the return key to dismiss the keyboard
        return true
        
    }
    
}
