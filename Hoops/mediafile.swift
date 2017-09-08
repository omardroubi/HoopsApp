//
//  mediafile.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/12/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation

struct mediafile {
    var filename: String
    var mediaurl: String
    
    func toAnyObject() -> NSDictionary {
        return ["File Name": filename, "Media": mediaurl]
        
        
    }
}
