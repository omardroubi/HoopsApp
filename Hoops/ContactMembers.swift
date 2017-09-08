//
//  ContactMembers.swift
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

class ContactMembers: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var titleFansMessage: UITextField!
    @IBOutlet var messageFansText: UITextField!
    
    var eventRefAdd = FIRDatabase.database().reference().child("Messages to Fans")
    
    @IBAction func submitMessageFans(_ sender: Any) {
        if (titleFansMessage.text! == "" || messageFansText.text! == "") {
            let alert = UIAlertController(title: "Field missing", message: "Please fill all the required fields", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            let eventRefAdd = self.eventRefAdd.child(titleFansMessage.text!)
            
            eventRefAdd.setValue(["Title": titleFansMessage.text!, "Message": messageFansText.text!])
            
        }
        
    }
    
    
    
    @IBAction func contactAllManagers(_ sender: Any) {
        // text to share
        //managersOnlyGroup
        
        var emailsSend: String = "Send this message to: "
        
        for managers in managersOnlyGroup {
            emailsSend += " " + managers.email
        }
        
        
        let text = emailsSend
        
        // set up activity view controller
        let textToShare = [emailsSend]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func contactAllCoaches(_ sender: Any) {
        // text to share
        var emailsSend: String = "Send this message to: "
        
        for coaches in coachesOnlyGroup {
            emailsSend += " " + coaches.email
        }
        
        
        let text = emailsSend
        
        
        // set up activity view controller
        let textToShare = [emailsSend]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func contactAllPlayers(_ sender: Any) {
        // text to share
        var emailsSend: String = "Send this message to: "
        
        for players in playersOnlyGroup {
            emailsSend += " " + players.email
        }
        
        
        let text = emailsSend
        
        // set up activity view controller
        let textToShare = [emailsSend]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
        
    }
    
    var personsList = [Person]()
    
    var playersOnlyGroup = [Person]()
    var coachesOnlyGroup = [Person]()
    var managersOnlyGroup = [Person]()
    
    
    var eventRef: FIRDatabaseReference!
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
            self.playersOnlyGroup.append(addToList)
            
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
            self.managersOnlyGroup.append(addToList)
            
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
            self.coachesOnlyGroup.append(addToList)
            
            self.tableView.reloadData()
            
            
        })
        self.tableView.reloadData()
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("Row is selected")
        // text to share
        let text = personsList[indexPath.row].email
        
        // set up activity view controller
        let textToShare = [personsList[indexPath.row].email]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personsList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        
        cell.textLabel?.text = personsList[indexPath.row].role + " " + personsList[indexPath.row].name
        
        return cell
    }
    
    
    
    
    
    
    
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
    
}
