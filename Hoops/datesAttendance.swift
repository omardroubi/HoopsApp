//
//  datesAttendance.swift
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

class datesAttendance: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var name = "Lebron James"
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var datesList = [String]()
    
    
    var eventRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("After " + self.name)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)
        
        eventRef = FIRDatabase.database().reference()
        eventRef.child("Attendance List").child(self.name).queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            var snapshotValue = snapshot.value as? NSDictionary
            let date = snapshotValue!["Date"] as! String
            
            self.datesList.append(date)
            
            self.tableView.reloadData()
            
        })
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datesList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = datesList[indexPath.row]
        
        return cell
    }
    
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
}
