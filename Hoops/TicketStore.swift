//
//  TicketStore.swift
//  

//  Created by Vanessa Nader and Omar Droubi
//  EECE 430 American University of Beirut
//  HOOPS APP

import Foundation
import Firebase

//this is the class where the user can choose the events he wants to buy tickets for
class TicketStore : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ticketRefwrite = FIRDatabase.database().reference().child("Tickets") //create a reference to the Tickets category in the database to be able to write
    var ticketList : [ticketstruct] = [] //create a list of ticket structs
    @IBOutlet var menu: UIBarButtonItem!
    var ticketRef: FIRDatabaseReference! //create a database refrence to be able to read
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)

        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer()) // for toggling the menu button
        menu.target = self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        //Read the database for polls
        ticketRef = FIRDatabase.database().reference()
        ticketRef.child("Tickets").queryOrderedByKey().observe(.childAdded, with: { // read the database for all elements in the Tickets category
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let event = snapshotValue!["Event"] as! String //parse through the subcategories of Tickets and store the values in local variables
            let eventinfo = snapshotValue!["Event Information"] as! String
            let eventID = snapshotValue!["Event ID"] as! Int
            let vip = snapshotValue!["Number of VIP tickets"] as! Int
            let regular = snapshotValue!["Number of regular tickets"] as! Int
            let pvip = snapshotValue!["Price of VIP tickets"] as! Int
            let pregular = snapshotValue!["Price of regular tickets"] as! Int
            let available = snapshotValue!["Availability for purchase"] as! Bool
            
            
            let newTicket: ticketstruct = ticketstruct(eventname: event, eventinfo: eventinfo, eventid: eventID, numbervip: vip, numberregular: regular, pricevip: pvip, priceregular: pregular, available: available) //create a new tickt struct
            
            if newTicket.available == true { //check if the tickets are available for sale. If they are not then they are not appended to the ticket list and therefore not displayed to the fans.
            
            self.ticketList.append(newTicket) // if they are available they are displayed to the fan
            
            self.table.reloadData() //reload the data with the new elements added to it
            }
            
        })
        
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketList.count //return the number oif rows in the table
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TicketFanCell", owner: self, options: nil)?.first as! TicketFanCell //create a prototype cell in the table view of type TicketFanCell
        
        
        cell.eventname.text = ticketList[indexPath.row].eventname //display all the elements of the event at the index at the cell
        cell.eventinfo.text = ticketList[indexPath.row].eventinfo
        cell.ticketsVIP.text = String(ticketList[indexPath.row].numbervip)
        cell.ticketsregular.text = String(ticketList[indexPath.row].numberregular)
        cell.pticketsVIP.text = String(ticketList[indexPath.row].pricevip)
        cell.pticketsregular.text = String(ticketList[indexPath.row].priceregular)
 
        
        
        cell.eventname.sizeToFit() //size the elements to fill the tableview cell
        cell.eventinfo.sizeToFit()
        cell.ticketsregular.sizeToFit()
        cell.ticketsVIP.sizeToFit()
        cell.pticketsVIP.sizeToFit()
        cell.pticketsregular.sizeToFit()
        
        
        cell.sizeToFit()
        
        
        return cell //display the cell in the table
    }
    @IBOutlet var table: UITableView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSeatPlan", sender: ticketList[indexPath.row]) //define what row in the table was pressed
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //send the right values to the next scene according to what cell was pressed
        if segue.identifier == "toSeatPlan" {
            let guest = segue.destination as! TicketTypeBuy //set the destination as TicketTypeBuy
            guest.event = sender as! ticketstruct //send what event has been chosen by the user to buy tickets of
        }
        
        
        
        
    }

    
}
