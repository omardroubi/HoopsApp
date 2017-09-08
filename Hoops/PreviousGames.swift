//
//  PreviousGames.swift
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

class PreviousGames: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var games = [GameScore]()
    
    var eventRef: FIRDatabaseReference!
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func cancel(_ sender: Any) {
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

    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)

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
