//
//  Polls.swift
//  Hoops
//
//  Created by Omar Droubi on 11/24/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation

class Polls: UIViewController {

    @IBOutlet weak var menu: UIBarButtonItem!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)

        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        menu.target = self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
    }
    
}
