//
//  UpdatePlayerInformation.swift
//  Hoops
//
//  Created by Omar Droubi on 12/12/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//


import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class UpdatePlayerInformation: UIViewController {
    var eventRef: FIRDatabaseReference!
    var personsList = [Person]()

    
    @IBOutlet var newPassword: UITextField!
    
    @IBOutlet var newPersonalInfo: UITextView!
    
    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updatePersonalInfo(_ sender: Any) {
        
        if (newPassword.text! == "" || newPersonalInfo.text! == "") {
            let alert = UIAlertController(title: "Field missing", message: "Please fill all the required fields", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            
        } else {
            let userEmail = FIRAuth.auth()?.currentUser?.email!

            for person in personsList {
                if person.email == userEmail {
                    
                    //
                    var plural: String = "s"
                    if (person.role == "Coach") {
                        plural = "es"
                    }
                    
                    // update database
                    let eventRef = self.eventRef.child(person.role + plural).child(person.name).child("Personal Information")
                    
                    eventRef.setValue(newPersonalInfo.text!)
                    
                    let eventRefPI = self.eventRef.child(person.role + plural).child(person.name).child("Password")
                    
                    eventRefPI.setValue(newPassword.text!)

                    ///////
                }
            }
        }
    
            
            
            
        }
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)

        // Read DATABASE AGAIN, remove everything in the array and then add everything back inside to update the table
        
        // Add the players
        eventRef = FIRDatabase.database().reference()
        eventRef.child("Players").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            var snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue!["Name"] as! String
            let email = snapshotValue!["Email"] as! String
            let password = snapshotValue!["Password"] as! String
            let personalInfo = snapshotValue!["Personal Information"] as! String
            var salary = snapshotValue!["Salary"] as! Int
            
            var addToList = Person(name: name, email: email, password: password, role: "Player", salary: salary, personalInfo: personalInfo)
            self.personsList.append(addToList)
            
            
        })
        // Add the managers
        eventRef = FIRDatabase.database().reference()
        eventRef.child("Managers").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue!["Name"] as! String
            let email = snapshotValue!["Email"] as! String
            let password = snapshotValue!["Password"] as! String
            let personalInfo = snapshotValue!["Personal Information"] as! String
            var salary = snapshotValue!["Salary"] as! Int
            
            var addToList = Person(name: name, email: email, password: password, role: "Manager", salary: salary, personalInfo: personalInfo)
            self.personsList.append(addToList)
            
            
            
        })
        // Add the coaches
        eventRef = FIRDatabase.database().reference()
        eventRef.child("Coaches").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue!["Name"] as! String
            let email = snapshotValue!["Email"] as! String
            let password = snapshotValue!["Password"] as! String
            let personalInfo = snapshotValue!["Personal Information"] as! String
            var salary = snapshotValue!["Salary"] as! Int
            
            var addToList = Person(name: name, email: email, password: password, role: "Coach", salary: salary, personalInfo: personalInfo)
            self.personsList.append(addToList)
            
            
        })
        

    }
    
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
}
