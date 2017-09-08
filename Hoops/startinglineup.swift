//
//  startinglineup.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/11/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation

struct startinglineup{
    var game: String
    var date: String
    var pointguard: String
    var shootingguard: String
    var smallforward: String
    var powerforward: String
    var center: String
    
    func toAnyObject() -> NSDictionary {
        return ["Game": game, "Date": date, "Point Guard": pointguard, "Shooting Guard": shootingguard, "Small Forward": smallforward, "Power Forward" : powerforward, "Center" : center ]
        
        
    }
    
}
