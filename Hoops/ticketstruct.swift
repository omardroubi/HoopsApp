//
//  ticketstruct.swift
//  Hoops
//
//  Created by Omar Droubi on 12/13/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation

struct ticketstruct {
    var eventname: String
    var eventinfo: String
    var eventid: Int
    var numbervip: Int
    var numberregular : Int
    var pricevip: Int
    var priceregular : Int
    var available : Bool
    
    func toAnyObject() -> NSDictionary {
        return ["Event" : eventname , "Event Information" : eventinfo, "Event ID" : eventid, "Number of VIP tickets": numbervip, "Number of regular tickets": numberregular, "Price of VIP tickets" : pricevip, "Price of regular tickets": priceregular,"Availability for purchase" : available]
}
}
