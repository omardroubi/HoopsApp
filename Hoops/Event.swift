//
//  Event.swift
//  
//
//  Created by Omar Droubi on 12/5/16.
//
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import Firebase

struct Event {
    var eventTitle: String!
    var location: String!
    var addedByUser: String!
    var duration: String!
    var notes: String!
    var date: String!
    let itemRef: FIRDatabaseReference?
    
    init(eventTitle: String, location: String, addedByUser: String, duration: String, notes: String, date: String) {
        self.eventTitle = eventTitle
        self.location = location
        self.addedByUser = addedByUser
        self.duration = duration
        self.notes = notes
        self.date = date
        self.itemRef = nil
    }
    
    init(snapshot:FIRDataSnapshot) {
        let snapshotValue = snapshot.value as? NSDictionary
        
        eventTitle = snapshot.key
        
        self.location = snapshot.key
        self.addedByUser = snapshot.key
        self.duration = snapshot.key
        self.notes = snapshot.key
        self.date = snapshot.key
        
        itemRef = snapshot.ref
        
        if let sweetTitle = snapshotValue!["Event Title"] as? String {
            eventTitle = sweetTitle
        } else {
            eventTitle = ""
        }

        if let sweetTitle = snapshotValue!["Location"] as? String {
            location = sweetTitle
        } else {
            location = ""
        }
        
        if let sweetUser = snapshotValue!["Added by"] as? String {
            addedByUser = sweetUser
        } else {
            addedByUser = ""
        }
        
        if let sweetUser = snapshotValue!["Start Time"] as? String {
            duration = sweetUser
        } else {
            duration = ""
        }
        
        if let sweetUser = snapshotValue!["Notes"] as? String {
            notes = sweetUser
        } else {
            notes = ""
        }
        
        if let sweetUser = snapshotValue!["Date"] as? String {
            date = sweetUser
        } else {
            date = ""
        }

    }
    
    func toAnyObject() -> NSDictionary {
        return ["Event Title": eventTitle, "Location": location, "Added by": addedByUser, "Duration": duration, "Notes": notes, "Date": date]
        
    }
    
    func printItems() -> String {
        return "Event Title: " + eventTitle + " - Location: " + location + " - Added by : " + addedByUser + " - Duration: " + duration + "Notes" + notes + "Date" + date
    }
    
}
