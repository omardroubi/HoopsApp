//
//  Members.swift
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

struct Member {
    var name: String!
    var number: String!
    var position: String!
}

class Members: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var updatedPersonsList = [Person]()
    var namesList = [String]()
    var positionsList = [String]()
    
    @IBAction func sortByName(_ sender: Any) {
        
        namesList = namesList.sorted(by: <)
        print(namesList)
        
        
        updatedPersonsList.removeAll()
        
        
        for name in namesList {
            print(name)
            for player in playersList {
                print(player.name)
                print(name)
                if (player.name == name) {
                    updatedPersonsList.append(player)
                }
            }
        }
        
        self.tableView.reloadData()
        
        
    }
    
    @IBAction func sortByNumber(_ sender: Any) {
        updatedPersonsList.sort { (person1, person2) -> Bool in
            if person1.number < person2.number {
                return true
            }
            return false
        }
        self.tableView.reloadData()
        
    }
    
    @IBAction func sortByPosition(_ sender: Any) {
        
        positionsList = positionsList.sorted(by: <)
        print(positionsList)
        
        
        updatedPersonsList.removeAll()
        
        
        for name in positionsList {
            print(name)
            for player in playersList {
                
                if (player.position == name) {
                    updatedPersonsList.append(player)
                }
            }
        }
        
        self.tableView.reloadData()
        
        
    }
    
    
    var playersList = [Person]()
    var eventRef: FIRDatabaseReference!
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)
        
        // Read DATABASE AGAIN, remove everything in the array and then add everything back inside to update the table
        self.playersList.removeAll()
        
        eventRef = FIRDatabase.database().reference()
        eventRef.child("Players").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue!["Name"] as! String
            let email = snapshotValue!["Email"] as! String
            let password = snapshotValue!["Password"] as! String
            let personalInfo = snapshotValue!["Personal Information"] as! String
            let salary = snapshotValue!["Salary"] as! Int
            let number = snapshotValue!["Number"] as! Int
            let position = snapshotValue!["Position"] as! String
            
            self.playersList.append(Person(name: name, email: email, password: password, role: "Player", salary: salary, personalInfo: personalInfo, number: number, position: position))
            self.updatedPersonsList.append(Person(name: name, email: email, password: password, role: "Player", salary: salary, personalInfo: personalInfo, number: number, position: position))
            
            self.namesList.append(name)
            self.positionsList.append(position)
            
            self.tableView.reloadData()
            
            
        })
        self.tableView.reloadData()
        
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MemberCell", owner: self, options: nil)?.first as! MemberCell
        
        cell.name.text = updatedPersonsList[indexPath.row].name
        cell.number.text = String(updatedPersonsList[indexPath.row].number)
        cell.position.text = updatedPersonsList[indexPath.row].position
        
        
        return cell
    }
    
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    @IBOutlet var tableView: UITableView!
    
    
    
}
