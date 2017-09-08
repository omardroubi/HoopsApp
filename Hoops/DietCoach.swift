//
//  DietCoach.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/11/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DietCoach: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var dietRefwrite = FIRDatabase.database().reference().child("Diet Plans")

    @IBAction func cancel(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var table: UITableView!
    
    var dietList : [dietplan] = []
    var dietRef: FIRDatabaseReference!
    override func viewDidLoad() {
        //Read the database for polls
        dietRef = FIRDatabase.database().reference()
        dietRef.child("Diet Plans").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let player = snapshotValue!["Player"] as! String
            let startingdate = snapshotValue!["Starting Date"] as! String
            let endingdate = snapshotValue!["Ending Date"] as! String
            let diet = snapshotValue!["Diet"] as! String
            
            let newDiet: dietplan = dietplan(startingdate: startingdate, endingdate: endingdate, player: player, diet: diet)
            
            
            self.dietList.append(newDiet)
            
            self.table.reloadData()
            
        })
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dietList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DietCell", owner: self, options: nil)?.first as! DietCell
        
        cell.diet.text = dietList[indexPath.row].diet
        cell.player.text = dietList[indexPath.row].player
        cell.start.text = dietList[indexPath.row].startingdate
        cell.end.text = dietList[indexPath.row].endingdate
        
        cell.diet.sizeToFit()
        cell.player.sizeToFit()
        cell.start.sizeToFit()
        cell.end.sizeToFit()
        
        cell.sizeToFit()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            dietRefwrite.child(dietList[indexPath.row].player).removeValue()
            dietList.remove(at: indexPath.row)
            table.reloadData()
            
        }
    }
    
    
    
}
