//
//  Feedback.swift
//  Hoops
//
//  Created by Omar Droubi on 11/24/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

struct feedbackInfo {
    var name: String
    var email: String
    var feedbackText: String
    
    func toAnyObject() -> NSDictionary {
        return ["Name": name, "Email": email, "Feedback": feedbackText]
    }
    
    
}

class Feedback : UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var feedbackList = [feedbackInfo]()
    var feedbackRef: FIRDatabaseReference!
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet var menu: UIBarButtonItem!
    
    @IBOutlet var name: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var feedbackText: UITextField!
    
    var fbRef = FIRDatabase.database().reference().child("Feedbacks")
    
    
    @IBOutlet var table: UITableView!
    
    @IBAction func addFeedback(_ sender: UIButton) {
        
        let newFeedback: feedbackInfo = feedbackInfo(name: name.text!, email: email.text!, feedbackText: feedbackText.text!)
        
        
        var check = true
        
        for item in feedbackList {
            if (item.name == newFeedback.name && item.email == newFeedback.email && item.feedbackText == newFeedback.feedbackText) {
                check = false
            }
        }
        
        
        if (name.text! == "") {
            let alert = UIAlertController(title: "Name missing", message: "Please enter your name", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
        else if (email.text! == "") {
            let alert = UIAlertController(title: "Email missing", message: "Please enter your email", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        else if (feedbackText.text! == "") {
            let alert = UIAlertController(title: "Feedback missing", message: "Please enter your feedback", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }else if (!(email.text!.contains("@"))){
            let alert = UIAlertController(title: "Email format error", message: "Please enter a valid email under Email address", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            
            feedbackList.append(newFeedback)
            let fbRef = self.fbRef.child(newFeedback.name)
            
            fbRef.setValue(newFeedback.toAnyObject())
            
            
        }
        table.reloadData()
    }
    
    
    override func viewDidLoad() {
        // Read DATABASE
        feedbackRef = FIRDatabase.database().reference()
        feedbackRef.child("Feedbacks").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue!["Name"] as! String
            let email = snapshotValue!["Email"] as! String
            let feedbackText = snapshotValue!["Feedback"] as! String
            
            let newFeedback: feedbackInfo = feedbackInfo(name: name, email: email, feedbackText: feedbackText)
            
            self.feedbackList.append(newFeedback)
            self.table.reloadData()
            
        })
        
        
        menu.target = self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.image.image = UIImage(named: "basketballCourt")
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbackList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("FeedbackCell", owner: self, options: nil)?.first as! FeedbackCell
        
        cell.name.text = feedbackList[indexPath.row].name
        cell.email.text = feedbackList[indexPath.row].email
        cell.feedbackText.text = feedbackList[indexPath.row].feedbackText
        
        
        return cell
    }
    
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        name.resignFirstResponder()
        email.resignFirstResponder()
        feedbackText.resignFirstResponder()
        
        return true
        
    }
    
}
