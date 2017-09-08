//
//  TicketReceipts.swift
//
//

//  Created by Vanessa Nader and Omar Droubi
//  EECE 430 American University of Beirut
//  HOOPS APP

import Foundation

struct TicketReceipts { //creating a structure for tickets to be able to manipulate them later
    
    var name: String
    
    var email :String
    
    var chosentype: String
    
    var numberOfTickets: Int

    
    var eventID: Int
    
    var typeOfPayment: String
    
    var amountPaid: Int
    
    var receiptNumber: Int
    
    func toAnyObject() -> NSDictionary { //convert the struct into a dictionary so that we can store it in the database
        return ["Name" : name, "Email" : email, "Chosen Type" : chosentype, "Number Of Tickets" : numberOfTickets, "Event ID" : eventID, "Type of Payment": typeOfPayment, "amountPaid": amountPaid, "Receipt Number": receiptNumber]
    }
    
}
