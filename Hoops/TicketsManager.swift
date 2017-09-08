//
//  TicketsManager.swift
//  Hoops
//
//  Created by Omar Droubi on 12/13/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase

class TicketsManager: UIViewController, UITableViewDelegate, UITableViewDataSource {
var ticketRefwrite = FIRDatabase.database().reference().child("Tickets")
    var ticketList : [ticketstruct] = []
    @IBAction func update(_ sender: Any) {
        self.ticketList.removeAll()
        //Read the database for polls
        ticketRef = FIRDatabase.database().reference()
        ticketRef.child("Tickets").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let event = snapshotValue!["Event"] as! String
            let eventinfo = snapshotValue!["Event Information"] as! String
            let eventID = snapshotValue!["Event ID"] as! Int
            let vip = snapshotValue!["Number of VIP tickets"] as! Int
            let regular = snapshotValue!["Number of regular tickets"] as! Int
            let pvip = snapshotValue!["Price of VIP tickets"] as! Int
            let pregular = snapshotValue!["Price of regular tickets"] as! Int
            let available = snapshotValue!["Availability for purchase"] as! Bool
            
            
            let newTicket: ticketstruct = ticketstruct(eventname: event, eventinfo: eventinfo, eventid: eventID, numbervip: vip, numberregular: regular, pricevip: pvip, priceregular: pregular, available: available)
            
            
            self.ticketList.append(newTicket)
            
            self.table.reloadData()
            
        })
    }
    var ticketRef: FIRDatabaseReference!
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)

        //Read the database for polls
        ticketRef = FIRDatabase.database().reference()
        ticketRef.child("Tickets").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let event = snapshotValue!["Event"] as! String
            let eventinfo = snapshotValue!["Event Information"] as! String
            let eventID = snapshotValue!["Event ID"] as! Int
            let vip = snapshotValue!["Number of VIP tickets"] as! Int
            let regular = snapshotValue!["Number of regular tickets"] as! Int
            let pvip = snapshotValue!["Price of VIP tickets"] as! Int
            let pregular = snapshotValue!["Price of regular tickets"] as! Int
            let available = snapshotValue!["Availability for purchase"] as! Bool
            
            
            let newTicket: ticketstruct = ticketstruct(eventname: event, eventinfo: eventinfo, eventid: eventID, numbervip: vip, numberregular: regular, pricevip: pvip, priceregular: pregular, available: available)
            
            
            self.ticketList.append(newTicket)
            
            self.table.reloadData()
            
        })
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TicketCell", owner: self, options: nil)?.first as! TicketCell
        
        
        cell.eventname.text = ticketList[indexPath.row].eventname
        cell.eventinfo.text = ticketList[indexPath.row].eventinfo
        cell.ticketsVIP.text = String(ticketList[indexPath.row].numbervip)
        cell.ticketsregular.text = String(ticketList[indexPath.row].numberregular)
        cell.pticketsVIP.text = String(ticketList[indexPath.row].pricevip)
        cell.pticketsregular.text = String(ticketList[indexPath.row].priceregular)
        cell.availability.text = String(ticketList[indexPath.row].available)
        
        cell.available.tag = indexPath.row
       cell.eventname.sizeToFit()
        cell.eventinfo.sizeToFit()
        cell.ticketsregular.sizeToFit()
        cell.ticketsVIP.sizeToFit()
        cell.pticketsVIP.sizeToFit()
        cell.pticketsregular.sizeToFit()
        cell.availability.sizeToFit()
        
        cell.sizeToFit()
        
        cell.available.addTarget(self, action: #selector(toggleavailability), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            ticketRefwrite.child(String(ticketList[indexPath.row].eventid)).removeValue()
            ticketList.remove(at: indexPath.row)
            self.table.reloadData()
            
        }
    }
    
    
    @IBAction func toggleavailability (sender: UIButton){
        if ticketList[sender.tag].available == true {
            ticketList[sender.tag].available = false
        } else {
            ticketList[sender.tag].available = true
        }
        
        let write = ticketRefwrite.child(String(ticketList[sender.tag].eventid))
        write.setValue(ticketList[sender.tag].toAnyObject())
        
        table.reloadData()

    }
    

    @IBOutlet var table: UITableView!

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toEdit", sender: ticketList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit" {
        let guest = segue.destination as! EditTickets
        guest.event = sender as! ticketstruct
        }
        
        
        

    }

}
