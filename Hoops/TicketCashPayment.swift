//
//  CashPayment.swift
//  

//  Created by Vanessa Nader and Omar Droubi
//  EECE 430 American University of Beirut
//  HOOPS APP

import UIKit
import Firebase
import FirebaseDatabase

//class for the cash payment
class TicketCashPayment: UIViewController {
    
    var event: ticketstruct = ticketstruct(eventname: "", eventinfo: "", eventid: 0, numbervip: 0, numberregular: 0, pricevip: 0, priceregular: 0, available: false) //create an event object for segues
    var name = "anything" //create a name string for the segue
    var email = "anything" //create an email string for the segue
    var donationamount = 0 //create an integer for the segue
    var chosentype = "VIP" //create a chosentype string for the segue
    var numberOfTickets = 0 // create an integer for the segue
    //var comment = ""
    var methodofpayment = "Cash" //create a string for the segue
     let receiptNum = arc4random_uniform(100000) //generate a random number between 0 and 100000 for the receipt, which is the primary key in the database
    var donationRef = FIRDatabase.database().reference().child("Tickets") //create a reference to the database table : Tickets
    
    var receiptRef = FIRDatabase.database().reference().child("Ticket Receipts") //create a reference to the database table : Ticket Receipts
    @IBOutlet weak var receiptnumber: UILabel! //connect the label that indicates the receipt number
    @IBOutlet weak var donorname: UILabel! //connect the label that indicates the buyer's name
    @IBOutlet weak var donoremail: UILabel! //connect the label that indicates the buyer's email
    
    @IBOutlet weak var donationnumber: UILabel! //connect the label that indicates the total amount to be paid for the tickets
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil) //disiss the current scene
    }
    @IBAction func done(_ sender: Any) {
        
       
        
        if chosentype == "VIP" { //if the user chose to buy VIP tickets
            
            
            if (donationamount >= event.numbervip) { //check if the user ordered more tickets than are actually still available
                donationamount = event.numbervip // if this is true limit him to the quantity still available
                event.available = false //remove the tickets from the user display because they are out of stock
            }
            let newTicket = ticketstruct(eventname: event.eventname, eventinfo: event.eventinfo, eventid: event.eventid, numbervip: event.numbervip - donationamount, numberregular: event.numberregular, pricevip: event.pricevip, priceregular: event.priceregular, available: event.available) //create a new ticketstruct
            
            let donationRef = self.donationRef.child(String(event.eventid)) //point to the event selected for the tickets
            
            donationRef.setValue(newTicket.toAnyObject()) //store the updated number of tickets left in the database
            
            let newTicketReceipt = TicketReceipts(name: name, email: email, chosentype: "VIP", numberOfTickets: self.donationamount, eventID: event.eventid, typeOfPayment: "Cash", amountPaid: donationamount * event.pricevip, receiptNumber: Int(receiptNum)) //create a new ticket receipt for the user
            
            let receiptRef = self.receiptRef.child(String(receiptNum)) //create a reference for the receipt using the random number generated earlier
            
            receiptRef.setValue(newTicketReceipt.toAnyObject()) //convert to dictionary
            let alert = UIAlertController(title: "Payment Successful", message: "Exit by pressing cancel", preferredStyle: UIAlertControllerStyle.alert) //show success
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            
        }
        
        if chosentype == "Regular" { //if the user chose to buy regular tickets. This if statement and its body are the same as before with the small difference that the numbers being updated in the database are actually the tickets left for the regular category.
            
            
            
            if (donationamount >= event.numberregular) {
                donationamount = event.numberregular
                event.available = false
            }
            let newTicket = ticketstruct(eventname: event.eventname, eventinfo: event.eventinfo, eventid: event.eventid, numbervip: event.numbervip, numberregular: event.numberregular - donationamount, pricevip: event.pricevip, priceregular: event.priceregular, available: event.available)
            
            let donationRef = self.donationRef.child(String(event.eventid))
            
            donationRef.setValue(newTicket.toAnyObject())
            
            let newTicketReceipt = TicketReceipts(name: name, email: email, chosentype: "Regular", numberOfTickets: self.donationamount, eventID: event.eventid, typeOfPayment: "Cash", amountPaid: donationamount * event.priceregular, receiptNumber: Int(receiptNum))
            
            let receiptRef = self.receiptRef.child(String(receiptNum))
            
            receiptRef.setValue(newTicketReceipt.toAnyObject())
            let alert = UIAlertController(title: "Payment Successful", message: "Exit by pressing cancel", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
        }
        
        
    }

    
    override func viewDidLoad() { //set the scenery for the user
        receiptnumber.text = "\(receiptNum)" // display the receipt number on the label
        donorname.text = name //display the donor's name on the label
        donoremail.text = email //display the donor's email on the label
        if chosentype == "VIP" { //if VIP tickets were chosen
            
            
            if (donationamount >= event.numbervip) { //check if the amounted requested exceeds the amount available
                donationamount = event.numbervip
            }
            donationnumber.text = "\(donationamount*event.pricevip)" //display the total price of the tickets to be purchased
            
        }
        if chosentype == "Regular" { //If regular tickets were chosen
            
            
            if (donationamount >= event.numberregular) {
                donationamount = event.numberregular
                
            }
            donationnumber.text = "\(donationamount*event.priceregular)" //display the total price of the tickets to be purchased

        }

        
        // Do any additional setup after loading the view.
    }
    

    
 
    
}
