//
//  pollstruct.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/10/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation

struct poll {
    var title: String
    var answers: [String]
    var statistics: [Int]
    var numberofresponses: Int
    
    func toAnyObject() -> NSDictionary {
        return ["Title": title, "Answers": answers, "Statistics": statistics, "Responses": numberofresponses ]
        
    
}
}
