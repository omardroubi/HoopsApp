//
//  dietplan.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/11/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation

struct dietplan {
    var startingdate : String
    var endingdate: String
    var player: String
    var diet: String
    
    func toAnyObject() -> NSDictionary {
    return ["Player": player, "Starting Date": startingdate, "Ending Date": endingdate, "Diet": diet ]
    
    
    }
}
