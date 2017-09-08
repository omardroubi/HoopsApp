//
//  Players.swift
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

class Coaches: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var birthdate: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var salary: UITextField!
    
    var playersList = [Person]()
    
    var eventRef: FIRDatabaseReference!
    
    var eventRefAdd = FIRDatabase.database().reference().child("Coaches")
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addPlayer(_ sender: Any) {
        
        if (name.text! == "" || email.text! == "" || password.text! == "" || birthdate.text! == "" || phoneNumber.text! == "" || salary.text! == "" ) {
            let alert = UIAlertController(title: "Field missing", message: "Please fill all the required fields", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }else if (!(email.text!.contains("@"))){
            let alert = UIAlertController(title: "Email format error", message: "Please enter a valid email under Email address", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else {
            
            let newPlayer = Person(name: name.text!, email: email.text!, password: password.text!, role: "Coach", salary: Int(salary.text!)!, personalInfo: "Birthday: " + birthdate.text! + " Address & Phone Number: " + phoneNumber.text!)
            
            let eventRefAdd = self.eventRefAdd.child(self.name.text!)
            
            eventRefAdd.setValue(newPlayer.toAnyObject())
            
            FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in })
        }
    }
    
    
    
    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)
        
        // Read DATABASE AGAIN, remove everything in the array and then add everything back inside to update the table
        self.playersList.removeAll()
        
        eventRef = FIRDatabase.database().reference()
        eventRef.child("Coaches").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue!["Name"] as! String
            let email = snapshotValue!["Email"] as! String
            let password = snapshotValue!["Password"] as! String
            let personalInfo = snapshotValue!["Personal Information"] as! String
            let salary = snapshotValue!["Salary"] as! Int
            
            self.playersList.append(Person(name: name, email: email, password: password, role: "Coach", salary: salary, personalInfo: personalInfo))
            
            self.tableView.reloadData()
            
            for player in self.playersList {
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in })
            }
            
        })
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MembersInformationCell", owner: self, options: nil)?.first as! MembersInformationCell
        
        cell.name.text = playersList[indexPath.row].name
        cell.email.text = playersList[indexPath.row].email
        cell.personalInfo.text = playersList[indexPath.row].personalInfo
        cell.salary.text = "$" + String(playersList[indexPath.row].salary) + " per month"
        
        return cell
    }
    
    // Delete a player from the database
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            eventRef = FIRDatabase.database().reference()
            eventRef.child("Coaches").child(playersList[indexPath.row].name).removeValue()
            print("Player Deleted!")
            
        }
        // Read DATABASE AGAIN, remove everything in the array and then add everything back inside to update the table
        self.playersList.removeAll()
        
        eventRef = FIRDatabase.database().reference()
        eventRef.child("Coaches").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue!["Name"] as! String
            let email = snapshotValue!["Email"] as! String
            let password = snapshotValue!["Password"] as! String
            let personalInfo = snapshotValue!["Personal Information"] as! String
            let salary = snapshotValue!["Salary"] as! Int
            
            self.playersList.append(Person(name: name, email: email, password: password, role: "Coach", salary: salary, personalInfo: personalInfo))
            
            self.tableView.reloadData()
            
            for player in self.playersList {
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in })
            }
            
            
        })
        self.tableView.reloadData()
        
        
    }
    
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
}
