//
//  User.swift
//  Hoops
//
//  Created by Omar Droubi on 12/5/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation
import FirebaseAuth


struct user {
    let uid: String
    let email: String

    init(userData: FIRUser) {
        uid = userData.uid
        
        if let mail = userData.providerData.first?.email {
            email = mail;
        } else {
            email = ""
        }
    }
    
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
