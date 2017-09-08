//
//  Calendar.swift
//  Hoops
//
//  Created by Omar Droubi on 11/24/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation

class Calendar : UIViewController {
    
    
    
    override func viewDidLoad() {
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
}
