//
//  ViewSalary.swift
//  Hoops
//
//  Created by Omar Droubi on 12/11/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class ViewSalary: UIViewController {
    
    @IBOutlet var salaryValue: UILabel!
    var eventRef: FIRDatabaseReference!
    
    var personsList = [Person]()
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        let image: UIImageView = UIImageView.init(image: UIImage(named: "salaryBackground.jpg")!)
        image.contentMode = UIViewContentMode.scaleToFill
        
        self.view.backgroundColor = UIColor(patternImage: image.image!)
        
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
            let userEmail = FIRAuth.auth()?.currentUser?.email!
            if email == userEmail {
                self.salaryValue.text = "$" + String(salary) + "/month"
            }
            
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
            let userEmail = FIRAuth.auth()?.currentUser?.email!
            if email == userEmail {
                self.salaryValue.text = "$" + String(salary) + "/month"
            }
            
            
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
            
            let userEmail = FIRAuth.auth()?.currentUser?.email!
            if email == userEmail {
                self.salaryValue.text = "$" + String(salary) + "/month"
            }
            
            
            var addToList = Person(name: name, email: email, password: password, role: "Coach", salary: salary, personalInfo: personalInfo)
            self.personsList.append(addToList)
            
        })
        
        print("Searched persons")
        
        
        
    }
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
}
