//
//  History.swift
//  Hoops
//
//  Created by Omar Droubi on 11/27/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//


import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class History: UIViewController {
    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet var textView: UITextView!
    
    var eventRef: FIRDatabaseReference!

    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)
        
        // Read DATABASE
        eventRef = FIRDatabase.database().reference()
        eventRef.child("History Information").queryOrderedByKey().observe(.value, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let information = snapshotValue!["History Text"] as! String
            
            self.textView.text = information
        })

    }
    

}
