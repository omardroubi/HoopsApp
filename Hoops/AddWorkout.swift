//
//  AddWorkout.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/11/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddWorkout: UIViewController, UITextFieldDelegate {
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    var workoutRef = FIRDatabase.database().reference().child("Workout Plans")

    @IBOutlet weak var playerTextField: UITextField!
    
    @IBOutlet weak var startTextField: UITextField!
    
    @IBOutlet weak var endTextField: UITextField!
    
    @IBOutlet weak var workoutTextField: UITextField!

    
    @IBAction func done(_ sender: Any) {
        var complete = true
        
        if ((playerTextField.text!=="") || (startTextField.text!=="") || (endTextField.text!=="") || (workoutTextField.text!=="")) {
            complete = false
            
        }
        
        if (complete){
            
            let newworkout = workoutplan(startingdate: startTextField.text!, endingdate: endTextField.text!, player: playerTextField.text!, workout: workoutTextField.text!)
            
            
            let workoutRef = self.workoutRef.child(playerTextField.text!)
            
            workoutRef.setValue(newworkout.toAnyObject())
            
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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)

        playerTextField.delegate = self
        startTextField.delegate = self
        endTextField.delegate = self
        workoutTextField.delegate = self

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        playerTextField.resignFirstResponder()
        startTextField.resignFirstResponder()
        endTextField.resignFirstResponder()
        workoutTextField.resignFirstResponder()
        return true
        
    }
    

}




