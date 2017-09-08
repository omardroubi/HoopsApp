//
//  donationstruct.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/10/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation

struct donation{
    var name: String
    var email: String
    var donationamount : Int
    var comments: String
    var methodofpayment : String
    var status: Bool
    var receiptnumber : Int
    
    func toAnyObject() -> NSDictionary {
        return ["Name" : name, "Email" : email, "Amount" : donationamount, "Comments" : comments, "Method Of Payment" : methodofpayment, "Receipt Number": receiptnumber, "Status": status]
        
        
    }
}
