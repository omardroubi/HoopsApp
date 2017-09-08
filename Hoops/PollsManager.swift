//
//  PollsManager.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/9/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import Foundation
    


class PollsManager: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var pollRefwrite = FIRDatabase.database().reference().child("Polls")
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBOutlet weak var table: UITableView!

    var pollList : [poll] = []
    var pollRef: FIRDatabaseReference!
    override func viewDidLoad() {
        //Read the database for polls
        pollRef = FIRDatabase.database().reference()
        pollRef.child("Polls").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let title = snapshotValue!["Title"] as! String
            let answers = snapshotValue!["Answers"] as! [String]
            let statistics = snapshotValue!["Statistics"] as! [Int]
            let numberofresponses = snapshotValue!["Responses"] as! Int
            
            let newPoll: poll = poll(title: title, answers: answers, statistics: statistics, numberofresponses : numberofresponses)
            
            
            self.pollList.append(newPoll)
            
            self.table.reloadData()

        })
    }
    
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return pollList.count
        }
        
        
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let pcell = Bundle.main.loadNibNamed("PollCell", owner: self, options: nil)?.first as! PollCell
            
            pcell.title.text = pollList[indexPath.row].title
            pcell.answer1.text = pollList[indexPath.row].answers[0]
            pcell.answer2.text = pollList[indexPath.row].answers[1]
            pcell.answer3.text = pollList[indexPath.row].answers[2]
            pcell.answer4.text = pollList[indexPath.row].answers[3]
            pcell.statistic1.text = "\(pollList[indexPath.row].statistics[0])"
            pcell.statistic2.text = "\(pollList[indexPath.row].statistics[1])"
            pcell.statistic3.text = "\(pollList[indexPath.row].statistics[2])"
            pcell.statistic4.text = "\(pollList[indexPath.row].statistics[3])"
            pcell.responses.text = "\(pollList[indexPath.row].numberofresponses)"
            
            
            pcell.title.sizeToFit()
            pcell.answer1.sizeToFit()
            pcell.answer2.sizeToFit()
            pcell.answer3.sizeToFit()
            pcell.answer4.sizeToFit()
            pcell.statistic1.sizeToFit()
            pcell.statistic2.sizeToFit()
            pcell.statistic3.sizeToFit()
            pcell.statistic4.sizeToFit()
            pcell.responses.sizeToFit()
            
            pcell.sizeToFit()
            
            return pcell
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            pollRefwrite.child(pollList[indexPath.row].title).removeValue()
            pollList.remove(at: indexPath.row)
            table.reloadData()
            
        }
    }

    
    
}



