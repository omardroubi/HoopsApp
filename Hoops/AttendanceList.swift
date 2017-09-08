//
//  AttendanceList.swift
//  Hoops
//
//  Created by Omar Droubi on 12/11/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//


import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class AttendanceList: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var namesList = [String]()
    var playersList = [Person]()
    
    var eventRef: FIRDatabaseReference!
    
    var name: String!
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let guest = segue.destination as! datesAttendance
        guest.name = sender as! String
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(playersList[indexPath.row].name)
        //print(namesList[indexPath.row])
        
        performSegue(withIdentifier: "toDates", sender: playersList[indexPath.row].name)
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("MembersInformationCell", owner: self, options: nil)?.first as! MembersInformationCell
        
        cell.name.text = playersList[indexPath.row].name
        cell.email.text = playersList[indexPath.row].email
        cell.personalInfo.text = playersList[indexPath.row].personalInfo
        cell.salary.text = "$" + String(playersList[indexPath.row].salary) + " per month"
        
        return cell
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)
        
        // Read DATABASE AGAIN, remove everything in the array and then add everything back inside to update the table
        eventRef = FIRDatabase.database().reference()
        eventRef.child("Players").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue!["Name"] as! String
            let email = snapshotValue!["Email"] as! String
            let password = snapshotValue!["Password"] as! String
            let personalInfo = snapshotValue!["Personal Information"] as! String
            let salary = snapshotValue!["Salary"] as! Int
            
            self.playersList.append(Person(name: name, email: email, password: password, role: "Player", salary: salary, personalInfo: personalInfo))
            
            self.tableView.reloadData()
            
            
        })
        
        
        for player in self.playersList {
            print(player.name)
            self.namesList.append(player.name)
        }
        print(namesList)
        
    }
    
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
    
}
