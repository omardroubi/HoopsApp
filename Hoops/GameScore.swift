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

struct GameScore {
    var homeTeam: String!
    var awayTeam: String!
    var homeScore: String!
    var awayScore: String!
    var date: String!
    let itemRef: FIRDatabaseReference?
    
    init(homeTeam: String, awayTeam: String, homeScore: String, awayScore: String, date: String) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeScore = homeScore
        self.awayScore = awayScore
        self.date = date
        self.itemRef = nil
    }
    
    init(snapshot:FIRDataSnapshot) {
        let snapshotValue = snapshot.value as? NSDictionary
                
        self.homeTeam = snapshot.key
        self.awayTeam = snapshot.key
        self.homeScore = snapshot.key
        self.awayScore = snapshot.key
        self.date = snapshot.key
        
        itemRef = snapshot.ref
        
        if let sweetTitle = snapshotValue!["Home Team"] as? String {
            homeTeam = sweetTitle
        } else {
            homeTeam = ""
        }
        
        if let sweetTitle = snapshotValue!["Away Team"] as? String {
            awayTeam = sweetTitle
        } else {
            awayTeam = ""
        }
        
        if let sweetUser = snapshotValue!["Home Score"] as? String {
            homeScore = sweetUser
        } else {
            homeScore = ""
        }
        
        if let sweetUser = snapshotValue!["Away Score"] as? String {
            awayScore = sweetUser
        } else {
            awayScore = ""
        }
        
        if let sweetUser = snapshotValue!["Date"] as? String {
            date = sweetUser
        } else {
            date = ""
        }
        
    }
    
    func toAnyObject() -> NSDictionary {
        return ["Home Team": homeTeam, "Away Team": awayTeam, "Home Score": homeScore, "Away Score": awayScore, "Date": date]
        
    }
    
}
