//
//  TicketCell.swift
//  Hoops
//
//  Created by Omar Droubi on 12/13/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit

class TicketCell: UITableViewCell {
    @IBOutlet var eventname: UILabel!
    @IBOutlet var eventinfo: UILabel!
    @IBOutlet var ticketsVIP: UILabel!
    @IBOutlet var ticketsregular: UILabel!
    @IBOutlet var pticketsVIP: UILabel!
    @IBOutlet var pticketsregular: UILabel!
    @IBOutlet var availability: UILabel!

    @IBOutlet var available: UIButton!
   
}
