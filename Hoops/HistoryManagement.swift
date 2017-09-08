//
//  HistoryManagement.swift
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

struct HistoryInformation {
    var historyText: String!
    let itemRef: FIRDatabaseReference?
    
    init(historyText: String) {
        self.historyText = historyText
        self.itemRef = nil
    }
    
    init(snapshot:FIRDataSnapshot) {
        let snapshotValue = snapshot.value as? NSDictionary
        
        self.historyText = snapshot.key
        
        itemRef = snapshot.ref
        
        if let sweetUser = snapshotValue!["History Text"] as? String {
            historyText = sweetUser
        } else {
            historyText = ""
        }
        
    }
    
    func toAnyObject() -> NSDictionary {
        return ["History Text": historyText]
        
    }
    
}

class HistoryManagement: UIViewController {
    @IBOutlet var newText: UITextView!
    @IBOutlet var previewText: UITextView!
    
    var eventRef: FIRDatabaseReference!
    
    var eventRefAdd = FIRDatabase.database().reference().child("History Information")
    
    
    // Add info to the database
    @IBAction func addNewText(_ sender: Any) {
        let historyInfo = HistoryInformation(historyText: self.newText.text)
        
        eventRefAdd.setValue(historyInfo.toAnyObject())
        
        // Read DATABASE
        eventRef = FIRDatabase.database().reference()
        eventRef.child("History Information").queryOrderedByKey().observe(.value, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let information = snapshotValue!["History Text"] as! String
            
            self.previewText.text = information
            self.newText.text = information
            
        })
    }
    
    
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)
        
        // Read DATABASE
        eventRef = FIRDatabase.database().reference()
        eventRef.child("History Information").queryOrderedByKey().observe(.value, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let information = snapshotValue!["History Text"] as! String
            
            self.previewText.text = information
            self.newText.text = information
        })
        
        
    }
    
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
}
