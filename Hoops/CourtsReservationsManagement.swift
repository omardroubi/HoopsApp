//
//  CourtsReservationsManagement.swift
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

class CourtsReservationsManagement: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var eventRef: FIRDatabaseReference!
    
    @IBOutlet var tableView: UITableView!
    
    
    var reservations = [Event]()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)
        
        // Read DATABASE
        eventRef = FIRDatabase.database().reference()
        eventRef.child("Court Reservations").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let eventTitle = snapshotValue!["Event Title"] as! String
            let location = snapshotValue!["Location"] as! String
            let addedByUser = snapshotValue!["Added by"] as! String
            let duration = snapshotValue!["Duration"] as! String
            let notes = snapshotValue!["Notes"] as! String
            let date = snapshotValue!["Date"] as! String
            
            self.reservations.append(Event(eventTitle: eventTitle, location: location, addedByUser: addedByUser, duration: duration, notes: notes, date: date))
            
            self.tableView.reloadData()
            
        })
        
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("EventCell", owner: self, options: nil)?.first as! EventCell
        
        cell.titleEvent.text = reservations[indexPath.row].eventTitle
        cell.location.text = reservations[indexPath.row].location
        cell.timeAndDuration.text = reservations[indexPath.row].date + "\n" + reservations[indexPath.row].duration + " minutes"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            eventRef = FIRDatabase.database().reference()
            eventRef.child("Court Reservations").child(reservations[indexPath.row].eventTitle).removeValue()
            print("Event Deleted!")
            
            
            
            // Read DATABASE AGAIN, remove everything in the array and then add everything back inside
            self.reservations.removeAll()
            
            eventRef = FIRDatabase.database().reference()
            eventRef.child("Court Reservations").queryOrderedByKey().observe(.childAdded, with: {
                
                snapshot in
                let snapshotValue = snapshot.value as? NSDictionary
                let eventTitle = snapshotValue!["Event Title"] as! String
                let location = snapshotValue!["Location"] as! String
                let addedByUser = snapshotValue!["Added by"] as! String
                let duration = snapshotValue!["Duration"] as! String
                let notes = snapshotValue!["Notes"] as! String
                let date = snapshotValue!["Date"] as! String
                
                self.reservations.append(Event(eventTitle: eventTitle, location: location, addedByUser: addedByUser, duration: duration, notes: notes, date: date))
                
                self.tableView.reloadData()
                
                
            })
        }
    }
    
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
}




