//
//  strategy.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/12/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation

struct strategy{
    var game: String
    var planurl: String
    
    func toAnyObject() -> NSDictionary {
        return ["Game": game, "Plan": planurl ]
        
        
    }
}
