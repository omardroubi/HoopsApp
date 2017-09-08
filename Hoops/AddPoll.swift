//
//  AddPoll.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/9/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import Firebase


class AddPoll: UIViewController, UITextFieldDelegate {
    
    var pollRef = FIRDatabase.database().reference().child("Polls")

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var answer1TextField: UITextField!
    @IBOutlet weak var answer2TextField: UITextField!
    @IBOutlet weak var answer3TextField: UITextField!
    @IBOutlet weak var answer4TextField: UITextField!

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var answers = [String]()
    
    
    @IBAction func addPoll(_ sender: Any) {
        
        var complete = true
        
        if ((titleTextField.text!=="") || (answer1TextField.text!=="") || (answer2TextField.text!=="") || (answer3TextField.text!=="") || (answer4TextField.text!=="")) {
            complete = false
            
        }
        
        if (complete){
        
        answers.append(answer1TextField.text!)
        answers.append(answer2TextField.text!)
        answers.append(answer3TextField.text!)
        answers.append(answer4TextField.text!)
        
        
    
        
        let newpoll = poll (title: titleTextField.text!, answers: answers , statistics: [0,0,0,0] , numberofresponses: 0)
        
        
        let pollRef = self.pollRef.child(titleTextField.text!)
        
        pollRef.setValue(newpoll.toAnyObject())
    
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
        titleTextField.delegate = self
        answer1TextField.delegate = self
        answer2TextField.delegate = self
        answer3TextField.delegate = self
        answer4TextField.delegate = self
   
}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        titleTextField.resignFirstResponder()
        answer1TextField.resignFirstResponder()
        answer2TextField.resignFirstResponder()
        answer3TextField.resignFirstResponder()
        answer4TextField.resignFirstResponder()
        return true
        
    }
}
