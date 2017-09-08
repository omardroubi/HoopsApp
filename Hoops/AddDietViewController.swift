//
//  AddDietViewController.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/11/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddDietViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var dietRef = FIRDatabase.database().reference().child("Diet Plans")

    @IBOutlet weak var playerTextField: UITextField!
    
    @IBOutlet weak var startTextField: UITextField!
    
    @IBOutlet weak var endTextField: UITextField!
    
    @IBOutlet weak var dietTextField: UITextField!

    @IBAction func done(_ sender: Any) {
        var complete = true
        
        if ((playerTextField.text!=="") || (startTextField.text!=="") || (endTextField.text!=="") || (dietTextField.text!=="")) {
            complete = false
            
        }
        
        if (complete){
           
            
            
            let newdiet = dietplan(startingdate: startTextField.text!, endingdate: endTextField.text!, player: playerTextField.text!, diet: dietTextField.text!)
            
            
            let dietRef = self.dietRef.child(playerTextField.text!)
            
            dietRef.setValue(newdiet.toAnyObject())
            
            dismiss(animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Incomplete Form", message: "Please fill all the fields before clicking Done", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            complete = true
        }
    }
    
    override func viewDidLoad() {
        playerTextField.delegate = self
        startTextField.delegate = self
        endTextField.delegate = self
        dietTextField.delegate = self

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        playerTextField.resignFirstResponder()
        startTextField.resignFirstResponder()
        endTextField.resignFirstResponder()
        dietTextField.resignFirstResponder()
        return true
        
    }

}

