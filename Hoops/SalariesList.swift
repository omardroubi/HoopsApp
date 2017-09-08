//
//  SalariesList.swift
//  Hoops
//
//  Created by Omar Droubi on 12/10/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class SalariesList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var personsList = [Person]()
    
    var eventRef: FIRDatabaseReference!
    
    @IBOutlet var email: UITextField!
    @IBOutlet var newSalary: UITextField!
    
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateSalary(_ sender: Any) {
        
        
        if (email.text! == "" || newSalary.text! == "") {
            let alert = UIAlertController(title: "Field missing", message: "Please fill all the required fields", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }else if (!(email.text!.contains("@"))){
            let alert = UIAlertController(title: "Email format error", message: "Please enter a valid email under Email address", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else {
            
            for person in personsList {
                if person.email == email.text! {
                    person.salary = Int(newSalary.text!)
                    
                    //
                    var plural: String = "s"
                    if (person.role == "Coach") {
                        plural = "es"
                    }
                    
                    // update database
                    let eventRef = self.eventRef.child(person.role + plural).child(person.name).child("Salary")
                    
                    eventRef.setValue(Int(newSalary.text!))
                    ///////
                }
            }
        }
        self.tableView.reloadData()
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
            
            self.tableView.reloadData()
            
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
            
            self.tableView.reloadData()
            
            
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
            
            self.tableView.reloadData()
            
            
        })
        self.tableView.reloadData()
        
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personsList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = personsList[indexPath.row].role + " " + personsList[indexPath.row].name
        cell.detailTextLabel?.text = "$" + String(personsList[indexPath.row].salary) + " per month"
        
        return cell
    }
    
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
    
}
