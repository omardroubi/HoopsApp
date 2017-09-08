//
//  Sweet.swift
//  Hoops
//
//  Created by Omar Droubi on 12/5/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Sweet {
    let key: String!
    let content: String!
    let addedByUser: String!
    let itemRef: FIRDatabaseReference?
    
    init(content: String, addedByUser: String, key: String = "" ) {
        self.key = key
        self.content = content
        self.addedByUser = addedByUser
        self.itemRef = nil
    }
    
    init(snapshot:FIRDataSnapshot) {
        let snapshotValue = snapshot.value as? NSDictionary
        key = snapshot.key
        itemRef = snapshot.ref
        
        if let sweetContent = snapshotValue!["content"] as? String {
            content = sweetContent
        } else {
            content = ""
        }
        
        if let sweetUser = snapshotValue!["addedByUser"] as? String {
            addedByUser = sweetUser
        } else {
            addedByUser = ""
        }
        
    }
    
    func toAnyObject() -> NSDictionary {
        return ["content":content, "addedByUser": addedByUser]
        
    }
    
}
