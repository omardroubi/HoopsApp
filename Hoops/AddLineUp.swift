//
//  AddLineUp.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/11/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddLineUp: UIViewController, UITextFieldDelegate {
    var lineupRef = FIRDatabase.database().reference().child("Starting Lineups")
    
    
    @IBAction func cancel(_ sender: Any) {
     dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        var complete = true
        
        if ((gameTextField.text!=="") || (dateTextField.text!=="") || (pgTextField.text!=="") || (sgTextField.text!=="") || (sfTextField.text!=="") || (pfTextField.text!=="") || (centerTextField.text!=="")) {
            complete = false
            
        }
        
        if (complete){
            
            
            
            let newlineup = startinglineup(game: gameTextField.text!, date: dateTextField.text!, pointguard: pgTextField.text!, shootingguard: sgTextField.text!, smallforward: sfTextField.text!, powerforward: pfTextField.text!, center: centerTextField.text!)
            
            
            let lineupRef = self.lineupRef.child(gameTextField.text!)
            
            lineupRef.setValue(newlineup.toAnyObject())
            
            dismiss(animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Incomplete Form", message: "Please fill all the fields before clicking Done", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            complete = true
        }
    }
    
    @IBOutlet weak var gameTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var pgTextField: UITextField!
    
    @IBOutlet weak var sgTextField: UITextField!
    
    @IBOutlet weak var sfTextField: UITextField!
    
    @IBOutlet weak var pfTextField: UITextField!
    
    @IBOutlet weak var centerTextField: UITextField!
    override func viewDidLoad() {
        gameTextField.delegate = self
        dateTextField.delegate = self
        pgTextField.delegate = self
        sgTextField.delegate = self
        sfTextField.delegate = self
        pfTextField.delegate = self
        centerTextField.delegate = self
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        gameTextField.resignFirstResponder()
        dateTextField.resignFirstResponder()
        pgTextField.resignFirstResponder()
        sgTextField.resignFirstResponder()
        sfTextField.resignFirstResponder()
        pfTextField.resignFirstResponder()
        centerTextField.resignFirstResponder()
        
        return true
        
    }
}
