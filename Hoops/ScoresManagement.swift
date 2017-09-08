//
//  ScoresManagement.swift
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

class ScoresManagement: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var newHomeTeam: UITextField!
    @IBOutlet var newAwayTeam: UITextField!
    @IBOutlet var newHomeScore: UITextField!
    @IBOutlet var newAwayScore: UITextField!
    @IBOutlet var date: UITextField!
    
    var games = [GameScore]()
    
    var eventRef: FIRDatabaseReference!
    
    var eventRefAdd = FIRDatabase.database().reference().child("Previous Games Scores")
    
    @IBOutlet var tableView: UITableView!
    
    
    // Add a game to the database
    @IBAction func addNewGame(_ sender: Any) {
        if (newHomeTeam.text! == "" || newAwayTeam.text! == "" || newHomeScore.text! == "" || newAwayScore.text! == "" || self.date.text! == "") {
            let alert = UIAlertController(title: "Field missing", message: "Please fill all the required fields", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            
        } else {
            let game = GameScore(homeTeam: newHomeTeam.text!, awayTeam: newAwayTeam.text!, homeScore: newHomeScore.text!, awayScore: newAwayScore.text!, date: self.date.text!)
            
            
            let eventRefAdd = self.eventRefAdd.child(self.date.text!)
            
            eventRefAdd.setValue(game.toAnyObject())
        }
        //self.tableView.reloadData()
    }
    
    // Main
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)
        
        // Read DATABASE AGAIN, remove everything in the array and then add everything back inside to update the table
        self.games.removeAll()
        
        eventRef = FIRDatabase.database().reference()
        eventRef.child("Previous Games Scores").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let newHomeTeam = snapshotValue!["Home Team"] as! String
            let newAwayTeam = snapshotValue!["Away Team"] as! String
            let newHomeScore = snapshotValue!["Home Score"] as! String
            let newAwayScore = snapshotValue!["Away Score"] as! String
            let date = snapshotValue!["Date"] as! String
            
            self.games.append(GameScore(homeTeam: newHomeTeam, awayTeam: newAwayTeam, homeScore: newHomeScore, awayScore: newAwayScore, date: date))
            
            self.tableView.reloadData()
            
        })
        
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = games[indexPath.row].homeTeam + " " + games[indexPath.row].homeScore + " - " + games[indexPath.row].awayScore + " " + games[indexPath.row].awayTeam
        cell.detailTextLabel?.text = games[indexPath.row].date
        
        return cell
    }
    
    // Delete a game from the database
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            eventRef = FIRDatabase.database().reference()
            eventRef.child("Previous Games Scores").child(games[indexPath.row].date).removeValue()
            print("Event Deleted!")
            
            
            
            
            // Read DATABASE AGAIN, remove everything in the array and then add everything back inside to update the table
            self.games.removeAll()
            
            // Read DATABASE
            eventRef = FIRDatabase.database().reference()
            eventRef.child("Previous Games Scores").queryOrderedByKey().observe(.childAdded, with: {
                
                snapshot in
                let snapshotValue = snapshot.value as? NSDictionary
                let homeTeam = snapshotValue!["Home Team"] as! String
                let awayTeam = snapshotValue!["Away Team"] as! String
                let homeScore = snapshotValue!["Home Score"] as! String
                let awayScore = snapshotValue!["Away Score"] as! String
                let date = snapshotValue!["Date"] as! String
                
                self.games.append(GameScore(homeTeam: homeTeam, awayTeam: awayTeam, homeScore: homeScore, awayScore: awayScore, date: date))
                
                self.tableView.reloadData()
                
            })
        }
    }
    
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
}
