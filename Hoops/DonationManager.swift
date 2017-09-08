//
//  DonationManager.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/11/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DonationManager: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var donationRefwrite = FIRDatabase.database().reference().child("Donation Requests")
    
    
    @IBOutlet weak var table: UITableView!
    
    var donationList : [donation] = []
    var donationRef: FIRDatabaseReference!
    override func viewDidLoad() {
        //Read the database for polls
        donationRef = FIRDatabase.database().reference()
        donationRef.child("Donation Requests").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let amount = snapshotValue!["Amount"] as! Int
            let comments = snapshotValue!["Comments"] as! String
            let email = snapshotValue!["Email"] as! String
            let methodofpayment = snapshotValue!["Method Of Payment"] as! String
            let name = snapshotValue!["Name"] as! String
            let receiptnumber = snapshotValue!["Receipt Number"] as! Int
            let status = snapshotValue!["Status"] as! Bool
            
            let newDonation: donation = donation(name: name, email: email, donationamount: amount, comments: comments, methodofpayment: methodofpayment, status: status, receiptnumber: receiptnumber)
            
            
            self.donationList.append(newDonation)
            
            self.table.reloadData()
            
        })
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donationList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DonationCell", owner: self, options: nil)?.first as! DonationCell
        
        cell.amount.text = "\(donationList[indexPath.row].donationamount)"
        cell.comments.text = donationList[indexPath.row].comments
        cell.methodofpayment.text = donationList[indexPath.row].methodofpayment
        cell.donorname.text = donationList[indexPath.row].name
        cell.donoremail.text = donationList[indexPath.row].email
        cell.receiptnum.text = "\(donationList[indexPath.row].receiptnumber)"
        
        cell.accept.tag = indexPath.row
        
        
        cell.accept.addTarget(self, action: #selector(accepted), for: UIControlEvents.touchUpInside)
        
        cell.amount.sizeToFit()
        cell.comments.sizeToFit()
        cell.methodofpayment.sizeToFit()
        cell.donorname.sizeToFit()
        cell.donoremail.sizeToFit()
        cell.receiptnum.sizeToFit()
        
        cell.sizeToFit()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            donationRefwrite.child("\(donationList[indexPath.row].receiptnumber)").removeValue()
            donationList.remove(at: indexPath.row)
            table.reloadData()
            
        }
    }
    
    @IBAction func accepted (sender: UIButton){
        donationList[sender.tag].status = true
        let write = donationRefwrite.child("\(donationList[sender.tag].receiptnumber)")
        write.setValue(donationList[sender.tag].toAnyObject())
        
        table.reloadData()
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}



