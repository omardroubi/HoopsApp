//
//  StrategiesPlayer.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/12/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase

class StrategiesPlayer: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated:true, completion: nil)
    }
    @IBOutlet weak var table: UITableView!
    var planList : [strategy] = []
    var planRef: FIRDatabaseReference!
    var planstorageRef : FIRStorageReference!
    
    
    var planRefwrite = FIRDatabase.database().reference().child("Plans")
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)

        // read the databse for Polls
        planRef = FIRDatabase.database().reference()
        planRef.child("Plans").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let game = snapshotValue!["Game"] as! String
            let imagereference = snapshotValue!["Plan"] as! String
            
            let newPlan: strategy = strategy(game: game, planurl: imagereference)
            self.planList.append(newPlan)
            
            self.table.reloadData()
            
        })
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : StrategyPlayerCell = table.dequeueReusableCell(withIdentifier: "cell", for : indexPath) as! StrategyPlayerCell
        
        cell.game.text = planList[indexPath.row].game
        
        planstorageRef = FIRStorage.storage().reference(forURL: planList[indexPath.row].planurl)
        planstorageRef.data(withMaxSize: 1*1024*1024, completion: {(data, error) in
            if error == nil {
                if let data = data {
                    cell.imagereference.image = UIImage(data: data)
                }
            } else {
                //
            }
            
            
        })
        cell.game.sizeToFit()
        cell.sizeToFit()
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            planRefwrite.child(planList[indexPath.row].game).removeValue()
            let storage = FIRStorage.storage()
            let storageRef = storage.reference(forURL: "gs://hoopsclub-b917e.appspot.com")
            let storageref = storageRef.child("plan/\(planList[indexPath.row].game)/planimage")
            storageref.delete(completion: { (error) in
                if error == nil {
                    self.planList.remove(at: indexPath.row)
                    self.table.reloadData()
                } else {
                    print (error!)
                }
            })
            table.reloadData()
            
        }
        
    }
}

