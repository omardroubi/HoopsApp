//
//  ViewController.swift
//  Hoops
//
//  Created by Omar Droubi on 11/22/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var menu: UIBarButtonItem!
    
    @IBOutlet var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        menu.target = self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

