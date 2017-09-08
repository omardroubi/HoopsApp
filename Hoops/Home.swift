//
//  Home.swift
//  Hoops
//
//  Created by Omar Droubi on 12/1/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

struct News {
    var title: String!
    var content: String!
}


class Home: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    
    @IBOutlet var homeScore: UILabel!
    @IBOutlet var awayScore: UILabel!
    
    var eventRef: FIRDatabaseReference!
    var eventRefMessages: FIRDatabaseReference!
    
    var newsList = [News]()
    
    @IBOutlet var menu: UIBarButtonItem!
    
    override func viewDidLoad() {
        // self.tableView.backgroundColor = UIColor.black
        
        menu.target = self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)
        
        
        // Read DATABASE
        eventRef = FIRDatabase.database().reference()
        eventRef.child("Previous Games Scores").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            self.homeScore.text = snapshotValue!["Home Score"] as! String
            self.awayScore.text = snapshotValue!["Away Score"] as! String
            
        })
        
        // Read NEWS
        eventRefMessages = FIRDatabase.database().reference()
        eventRefMessages.child("Messages to Fans").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            var titleMessage = snapshotValue!["Title"] as! String
            var MessageFans = snapshotValue!["Message"] as! String
            
            self.newsList.append(News(title: titleMessage, content: MessageFans))
            
            self.tableView.reloadData()
        })
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = newsList[indexPath.row].title
        cell.detailTextLabel?.text = newsList[indexPath.row].content
        
        return cell
        
    }
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
}
