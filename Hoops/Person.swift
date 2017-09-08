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

class Person {
    var name: String!
    var email: String!
    var password: String!
    var role: String!
    var salary: Int!
    var personalInfo: String!
    var itemRef: FIRDatabaseReference?
    var number: Int!
    var position: String!
    
    
    init(name: String, email: String, password: String, role: String, salary: Int, personalInfo: String) {
        self.name = name
        self.email = email
        self.password = password
        self.role = role
        self.salary = salary
        self.personalInfo = personalInfo
        self.itemRef = nil
        
        self.number = 1
        self.position = ""

    }

    init(name: String, email: String, password: String, role: String, salary: Int, personalInfo: String, number: Int, position: String) {
        self.name = name
        self.email = email
        self.password = password
        self.role = role
        self.salary = salary
        self.personalInfo = personalInfo
        self.itemRef = nil
        self.number = number
        self.position = position
    }
    
    init(name: String, email: String, password: String, role: String, salary: Int, personalInfo: String, countAttendance: Int) {
        self.name = name
        self.email = email
        self.password = password
        self.role = role
        self.salary = salary
        self.personalInfo = personalInfo
        self.itemRef = nil
        
        self.number = 1
        self.position = ""
    }

    init(snapshot:FIRDataSnapshot) {
        let snapshotValue = snapshot.value as? NSDictionary
        
        self.name = snapshot.key
        self.email = snapshot.key
        self.password = snapshot.key
        self.role = snapshot.key
        self.salary = snapshot.value as! Int!
        self.personalInfo = snapshot.key
        
        itemRef = snapshot.ref
        
        if let sweetTitle = snapshotValue!["Personal Information"] as? String {
            personalInfo = sweetTitle
        } else {
            personalInfo = ""
        }
        
        if let sweetTitle = snapshotValue!["Name"] as? String {
            name = sweetTitle
        } else {
            name = ""
        }
        
        if let sweetTitle = snapshotValue!["Email"] as? String {
            email = sweetTitle
        } else {
            email = ""
        }
        
        if let sweetUser = snapshotValue!["Password"] as? String {
            password = sweetUser
        } else {
            password = ""
        }
        
        if let sweetUser = snapshotValue!["Role"] as? String {
            role = sweetUser
        } else {
            role = ""
        }
        
        if var sweetUser = snapshotValue!["Salary"] as? Int {
            salary = sweetUser
        } else {
            salary = 0
        }
        
        if var sweetUser = snapshotValue!["Number"] as? Int {
            number = sweetUser
        } else {
            number = 0
        }

        if var sweetUser = snapshotValue!["Position"] as? String {
            position = sweetUser
        } else {
            position = ""
        }

    }
    
    func toAnyObject() -> NSDictionary {
        return ["Name": name, "Email": email, "Password": password, "Role": role, "Salary": salary, "Personal Information": personalInfo]
        
    }
    
}
