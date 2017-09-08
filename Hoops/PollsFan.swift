//
//  PollsFan.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/10/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class PollsFan: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBAction func done(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var table: UITableView!
    var pollList : [poll] = []
    var pollRef: FIRDatabaseReference!
    var answered = [Bool]()
   
    
    var pollRefwrite = FIRDatabase.database().reference().child("Polls")
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)

        // read the databse for Polls
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
            self.answered.append(false)
            
            self.table.reloadData()

        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pollList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PollFanCell = table.dequeueReusableCell(withIdentifier: "cell", for : indexPath) as! PollFanCell
        cell.questiontitle.text = pollList[indexPath.row].title
        cell.answer1.setTitle(pollList[indexPath.row].answers[0], for: .normal)
        cell.answer2.setTitle(pollList[indexPath.row].answers[1], for: .normal)
        cell.answer3.setTitle(pollList[indexPath.row].answers[2], for: .normal)
        cell.answer4.setTitle(pollList[indexPath.row].answers[3], for: .normal)
        cell.answer1.tag = indexPath.row
        cell.answer2.tag = indexPath.row
        
        cell.answer3.tag = indexPath.row
        
        cell.answer4.tag = indexPath.row
        
        
        cell.answer1.addTarget(self, action: #selector(chosen1), for: UIControlEvents.touchUpInside)
        cell.answer2.addTarget(self, action: #selector(chosen2), for: UIControlEvents.touchUpInside)
        cell.answer3.addTarget(self, action: #selector(chosen3), for: UIControlEvents.touchUpInside)
        cell.answer4.addTarget(self, action: #selector(chosen4), for: UIControlEvents.touchUpInside)
        cell.questiontitle.sizeToFit()
        cell.sizeToFit()
        
    
        return cell
    }

    @IBAction func chosen1 (sender: UIButton){
        if answered[sender.tag] == false {
            pollList[sender.tag].statistics[0] += 1
            pollList[sender.tag].numberofresponses += 1
            let write = pollRefwrite.child(pollList[sender.tag].title)
            write.setValue(pollList[sender.tag].toAnyObject())
            answered[sender.tag] = true
            self.table.reloadData()
       
            
            
            
            
            
        }
        else {
            let alert = UIAlertController(title: "Already answered", message: "You alreadt submitted an answer to this question", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func chosen2 (sender: UIButton){
        if answered[sender.tag] == false {
            pollList[sender.tag].statistics[1] += 1
            pollList[sender.tag].numberofresponses += 1
            let write = pollRefwrite.child(pollList[sender.tag].title)
            write.setValue(pollList[sender.tag].toAnyObject())
          
            table.reloadData()
            answered[sender.tag] = true
            
            
        }
        else {
            let alert = UIAlertController(title: "Already answered", message: "You alreadt submitted an answer to this question", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func chosen3 (sender: UIButton){
        if answered[sender.tag] == false {
            pollList[sender.tag].statistics[2] += 1
            pollList[sender.tag].numberofresponses += 1
            let write = pollRefwrite.child(pollList[sender.tag].title)
            write.setValue(pollList[sender.tag].toAnyObject())
           
            table.reloadData()
            answered[sender.tag] = true
            
            
        }
        else {
            let alert = UIAlertController(title: "Already answered", message: "You alreadt submitted an answer to this question", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func chosen4 (sender: UIButton){
        if answered[sender.tag] == false {
            pollList[sender.tag].statistics[3] += 1
            pollList[sender.tag].numberofresponses += 1
            let write = pollRefwrite.child(pollList[sender.tag].title)
            write.setValue(pollList[sender.tag].toAnyObject())
           

             table.reloadData()
            answered[sender.tag] = true
            
            
        }
        else {
            let alert = UIAlertController(title: "Already answered", message: "You alreadt submitted an answer to this question", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    


}
