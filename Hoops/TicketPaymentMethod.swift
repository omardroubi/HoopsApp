//
//  TicketPaymentMethod.swift
//  H

//  Created by Vanessa Nader and Omar Droubi
//  EECE 430 American University of Beirut
//  HOOPS APP

import UIKit

class TicketPaymentMethod: UIViewController {

    var event: ticketstruct = ticketstruct(eventname: "", eventinfo: "", eventid: 0, numbervip: 0, numberregular: 0, pricevip: 0, priceregular: 0, available: false) //create a ticket object for the segue

    var chosentype = "" //create a chosentype string for the segue
    
    var fullName = "" //create a fullname string for the segue
    
    var email = "" //create an email string for the segue
    
    var numberOfTickets = 0 //create a number of tickets integer for the segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)   { //this function helps us differentiate which button the user has pressed: credit card or cash payment
        if segue.identifier == "toCreditCardTicket" { //takes the app to the credit card scenery
            
            let guest = segue.destination as! TicketCreditCardPayment //set the credit card scene as the destination
            guest.event = event //pass values to the variables of the credit card payment scene
            guest.chosentype = chosentype
            guest.name = fullName
            guest.email = email
            guest.numberOfTickets = numberOfTickets
        }
        if segue.identifier == "toCashTicket" { //takes the app to the cash scenery
            
           let guest = segue.destination as! TicketCashPayment //set the cash scene as the destination
            guest.event = event //passs values to the variables of the cash payment scene
            guest.chosentype = chosentype
            guest.name = fullName
            guest.email = email
            guest.donationamount = numberOfTickets
        }
        
        
    }

    @IBAction func cancelEvent(_ sender: Any) {
        dismiss(animated: true, completion: nil) //dismiss the current scene
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}
