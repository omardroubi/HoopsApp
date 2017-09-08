//
//  WorkoutPlayer.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/11/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class WorkoutPlayer: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var workoutRefwrite = FIRDatabase.database().reference().child("Workout Plans")
    @IBOutlet weak var table: UITableView!
    var workoutList : [workoutplan] = []
    var workoutRef: FIRDatabaseReference!
    override func viewDidLoad() {
        workoutRef = FIRDatabase.database().reference()
        workoutRef.child("Workout Plans").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let player = snapshotValue!["Player"] as! String
            let startingdate = snapshotValue!["Starting Date"] as! String
            let endingdate = snapshotValue!["Ending Date"] as! String
            let workout = snapshotValue!["Workout"] as! String
            
            let newWorkout: workoutplan = workoutplan(startingdate: startingdate, endingdate: endingdate, player: player, workout: workout)
            
            
            self.workoutList.append(newWorkout)
            
            self.table.reloadData()
            
        })
        
        
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutList.count
    }
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("WorkoutCell", owner: self, options: nil)?.first as! WorkoutCell
        
        cell.workout.text = workoutList[indexPath.row].workout
        cell.player.text = workoutList[indexPath.row].player
        cell.startingdate.text = workoutList[indexPath.row].startingdate
        cell.endingdate.text = workoutList[indexPath.row].endingdate
        
        cell.workout.sizeToFit()
        cell.player.sizeToFit()
        cell.startingdate.sizeToFit()
        cell.endingdate.sizeToFit()
        
        cell.sizeToFit()
        
        return cell
    }
    

}
