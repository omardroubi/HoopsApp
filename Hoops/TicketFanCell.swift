//
//  TicketFanCell.swift
//  

//  Created by Vanessa Nader and Omar Droubi
//  EECE 430 American University of Beirut
//  HOOPS APP

import UIKit

//We link the elements in the .xib file in this cell in order to use them in each prototype cell of the table
class TicketFanCell: UITableViewCell {

    @IBOutlet var eventname: UILabel!

    @IBOutlet var eventinfo: UILabel!
    
    @IBOutlet var pticketsregular: UILabel!
    @IBOutlet var pticketsVIP: UILabel!
    @IBOutlet var ticketsregular: UILabel!
    @IBOutlet var ticketsVIP: UILabel!
}
