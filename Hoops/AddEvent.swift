//
//  AddEvent.swift
//  Hoops
//
//  Created by Omar Droubi on 11/26/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import Firebase

class AddEvent: UIViewController {
    
    @IBOutlet var eventTitle: UITextField!
    @IBOutlet var location: UITextField!
    @IBOutlet var notesField: UITextField!
    @IBOutlet var duration: UITextField!
    @IBOutlet var addedByUser: UITextField!
    
    var eventRef = FIRDatabase.database().reference().child("Schedule Events")
    
    @IBOutlet var date: UIDatePicker!
    
    var dateChosen: String = ""
    
    @IBAction func datePickerAction(sender: AnyObject) {
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var strDate = dateFormatter.string(from: self.date.date)
        self.dateChosen = strDate
        
    }
    
    @IBAction func cancelEvent(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addEvent(_ sender: Any) {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        
        
        if (eventTitle.text! == "") {
            let alert = UIAlertController(title: "Event title missing", message: "Please enter a title to your event", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
        else if (location.text! == "") {
            let alert = UIAlertController(title: "Event location missing", message: "Please enter a location to your event", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else if (addedByUser.text! == "") {
            let alert = UIAlertController(title: "Event's owner missing", message: "Please enter your name", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else if (duration.text! == "") {
            let alert = UIAlertController(title: "Event duration missing", message: "Please enter the length of your event in minutes", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            let event = Event(eventTitle: eventTitle.text!, location: location.text!, addedByUser: addedByUser.text!, duration: duration.text!, notes: notesField.text!, date: self.dateChosen)
            
            
            let eventRef = self.eventRef.child(eventTitle.text!)
            
            eventRef.setValue(event.toAnyObject())
            
            //self.present(sweetAlert, animated: true, completion: nil)
            
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var strDate = dateFormatter.string(from: self.date.date)
        self.dateChosen = strDate
        
        
    }
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
    
    
    
}
