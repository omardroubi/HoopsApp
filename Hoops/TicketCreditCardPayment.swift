//
//  CreditCardPayment.swift
//  

//  Created by Vanessa Nader and Omar Droubi
//  EECE 430 American University of Beirut
//  HOOPS APP

import UIKit
import Firebase
import FirebaseDatabase

//class for the credit card payment
class TicketCreditCardPayment: UIViewController, UITextFieldDelegate {
    
    
    
    var event: ticketstruct = ticketstruct(eventname: "", eventinfo: "", eventid: 0, numbervip: 0, numberregular: 0, pricevip: 0, priceregular: 0, available: false) //create an event object for the segue

    var donationRef = FIRDatabase.database().reference().child("Tickets") //reference to the Tickets database
    
    var receiptRef = FIRDatabase.database().reference().child("Ticket Receipts") //reference to the Ticket Receipts database
    
    
    
    
    var chosentype = "VIP" //create a chosentype string for the segue
    var name = "anything" //create a name string for the segue
    var email = "anything" //create an email string for the segue
    var donationamount = 0 //create an integer for the segue

    var methodofpayment = "Credit Card" //set the method of payment to be credit card in the database for this receipt
    
    var numberOfTickets = 0 //create a numberoftickets integer for the segue
    
    @IBOutlet weak var donationnumber: UILabel! //link the donationnumber label to the code
    @IBOutlet weak var cardnumber: UITextField!//link the cardnumber textfield to the code
    
    @IBOutlet weak var cardmonth: UITextField!//link the cardmonth textfield to the code
    
    @IBOutlet weak var cardyear: UITextField!//link the cardyear textfield to the code
    
    @IBOutlet weak var cvc: UITextField!//link the cvc textfield to the code
    
    
    
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil) //dismiss the scenery and go back to choosing the payment method
    }
    @IBAction func confirm(_ sender: Any) {
        let date = Date()
        let month = Calendar.current.component(.month, from: date) //get the month and the year to check the credit card's validity
        let year = Calendar.current.component(.year, from: date)
        
        if (cardnumber.text == ""){ //check if the card number textfield is empty
            let alert = UIAlertController(title: "Card number missing", message: "Please enter your card number", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else if (cardnumber.text!.characters.count != 16) //check is the card number isn't 16 digits, the typical number format for all credit cards
        {
            let alert = UIAlertController(title: "Card number wrong format", message: "Please enter your card number. It's a 16 digit number found at the front of the card", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        else if (cardmonth.text == "" ) { //check is the card month textfield is empty
            let alert = UIAlertController(title: "Expiry month missing", message: "Please enter your card's expiry date month", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        else if (cardyear.text == ""){ //check if the card year textfield is empty
            let alert = UIAlertController(title: "Expiry year missing", message: "Please enter your card's expiry date year", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }  else if (Int(cardyear.text!)! == 2016){ //if the cardyear's expiry date is this year check if the month of expiration is this month or later
            if (Int(cardmonth.text!)! <= 12) {
                let alert = UIAlertController(title: "Invalid card", message: "Please use a credit card that is not expired", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            }}
            else if (Int(cardyear.text!)! < 2016 || Int(cardmonth.text!)! > 12) { //check is the card year's expiration date was earlier
                let alert = UIAlertController(title: "Invalid card", message: "Please use a credit card that is not expired", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
            
        
        else if (cvc.text == ""){ //check if the cvc textfield is empty
            let alert = UIAlertController(title: "CVC missing", message: "Please enter your card's CVC found at the back of the card", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else if (cvc.text!.characters.count != 3) //check if the cvc textfield is 3 digits long, the typical format for cards' cvcs
        {
            let alert = UIAlertController(title: "CVC wrong format", message: "Please enter your card's CVC found at the back of the card. It's a 3 digit number", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
            
            
            
            
        else {
            
            
            let receiptNum = arc4random_uniform(100000) //create a random number for the receipt number between 0 and 100000
            
            if chosentype == "VIP" { // if the user chose to buy VIP tickets
                
            
                if (numberOfTickets >= event.numbervip) { //check if the amount requested is still available
                    numberOfTickets = event.numbervip //if not set the tickets to be bought to the amount still available
                    event.available = false //declare the tickets out of stock in the database
                }
            let newTicket = ticketstruct(eventname: event.eventname, eventinfo: event.eventinfo, eventid: event.eventid, numbervip: event.numbervip - numberOfTickets, numberregular: event.numberregular, pricevip: event.pricevip, priceregular: event.priceregular, available: event.available) //create a new ticket object for storage in the database
            
            let donationRef = self.donationRef.child(String(event.eventid)) //create a reference to the new object using the eventID
                
                donationRef.setValue(newTicket.toAnyObject()) //store the object in the database by converting it into a dictionary
                
                //create a new ticket receipt object for storage in the database
                let newTicketReceipt = TicketReceipts(name: name, email: email, chosentype: "VIP", numberOfTickets: self.numberOfTickets, eventID: event.eventid, typeOfPayment: "Credit Card", amountPaid: numberOfTickets * event.pricevip, receiptNumber: Int(receiptNum))
                let receiptRef = self.receiptRef.child(String(receiptNum)) //create a reference to the object using the random receipt number
                
                receiptRef.setValue(newTicketReceipt.toAnyObject()) //download it to the database
                let alert = UIAlertController(title: "Payment Successful", message: "Exit by pressing cancel", preferredStyle: UIAlertControllerStyle.alert) //announce the success of the transaction
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))

            
        }
            
            if chosentype == "Regular" { //the if statement and its body are the same as before with the only difference that the number of tickets to be updated is for the regular tickets
                
                
                
                if (numberOfTickets >= event.numberregular) {
                    numberOfTickets = event.numberregular
                    event.available = false
                }
                let newTicket = ticketstruct(eventname: event.eventname, eventinfo: event.eventinfo, eventid: event.eventid, numbervip: event.numbervip, numberregular: event.numberregular - numberOfTickets, pricevip: event.pricevip, priceregular: event.priceregular, available: event.available)
                
                let donationRef = self.donationRef.child(String(event.eventid))
                
                donationRef.setValue(newTicket.toAnyObject())
                
                let newTicketReceipt = TicketReceipts(name: name, email: email, chosentype: "Regular", numberOfTickets: self.numberOfTickets, eventID: event.eventid, typeOfPayment: "Credit Card", amountPaid: numberOfTickets * event.priceregular, receiptNumber: Int(receiptNum))
                
                let receiptRef = self.receiptRef.child(String(receiptNum))
                
                receiptRef.setValue(newTicketReceipt.toAnyObject())
                let alert = UIAlertController(title: "Payment Successful", message: "Exit by pressing cancel", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))

            }
            

        }
    }
    
    override func viewDidLoad() { //set the scenery for the suer
        super.viewDidLoad()
        cardnumber.delegate = self //announce the delegate of the textfields to be the class itself
        cardmonth.delegate = self
        cardyear.delegate = self
        cvc.delegate = self
        //donationnumber.text = "\(donationamount)"
        if chosentype == "VIP" { //display the amount due whether it is for VIP tickets or for regular tickets
            
            
            if (numberOfTickets >= event.numbervip) {
                numberOfTickets = event.numbervip
                            }
            donationnumber.text = "\(numberOfTickets*event.pricevip)"

        }
        if chosentype == "Regular" {
            
            
            if (numberOfTickets >= event.numberregular) {
                numberOfTickets = event.numberregular
               
            }
             donationnumber.text = "\(numberOfTickets*event.priceregular)"
        }

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true) //dismiss the keyboard when the user touches outside the textfield
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        cardnumber.resignFirstResponder() //dismiss the keyboard when the user pressed the return key
        cardmonth.resignFirstResponder()
        cardyear.resignFirstResponder()
        cvc.resignFirstResponder()
        return true
        
    }
    
    
    
}
