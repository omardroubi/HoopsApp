//
//  LineUpPlayer.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/11/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LineUpPlayer: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }

    @IBOutlet weak var table: UITableView!
    var lineupRefwrite = FIRDatabase.database().reference().child("Starting Lineups")
    var lineupList : [startinglineup] = []
    var lineupRef: FIRDatabaseReference!
    override func viewDidLoad() {
        lineupRef = FIRDatabase.database().reference()
        lineupRef.child("Starting Lineups").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let game = snapshotValue!["Game"] as! String
            let date = snapshotValue!["Date"] as! String
            let pointguard = snapshotValue!["Point Guard"] as! String
            let shootingguard = snapshotValue!["Shooting Guard"] as! String
            let smallforward = snapshotValue!["Small Forward"] as! String
            let powerforward = snapshotValue!["Power Forward"] as! String
            let center = snapshotValue!["Center"] as! String
            
            
            let newLineup: startinglineup = startinglineup(game: game, date: date, pointguard: pointguard, shootingguard: shootingguard, smallforward: smallforward, powerforward: powerforward, center: center)
            
            self.lineupList.append(newLineup)
            
            self.table.reloadData()
        })
        
        
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lineupList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("LineupCell", owner: self, options: nil)?.first as! LineupCell

        cell.game.text = lineupList[indexPath.row].game
        cell.date.text = lineupList[indexPath.row].date
        cell.pointguard.text = lineupList[indexPath.row].pointguard
        cell.shootingguard.text = lineupList[indexPath.row].shootingguard
        cell.smallforward.text = lineupList[indexPath.row].smallforward
        cell.powerforward.text = lineupList[indexPath.row].powerforward
        cell.centerlabel.text = lineupList[indexPath.row].center
        
        cell.game.sizeToFit()
        cell.date.sizeToFit()
        cell.pointguard.sizeToFit()
        cell.shootingguard.sizeToFit()
        cell.smallforward.sizeToFit()
        cell.powerforward.sizeToFit()
        cell.centerlabel.sizeToFit()
        
        cell.sizeToFit()
        
        return cell
    }
    
    
}


