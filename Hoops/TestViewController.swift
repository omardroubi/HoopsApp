//
//  TestViewController.swift
//  Hoops
//
//  Created by Omar Droubi on 5/22/17.
//  Copyright © 2017 Omar Droubi. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let button: UIButton = UIButton(frame: CGRect(x: 20, y: 50, width: 100, height: 100))
        
        button.setTitle("Menu", for: UIControlState.normal)
        button.titleLabel?.textColor = UIColor.red
        button.titleLabel!.font =  UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
        button.backgroundColor = UIColor.red

        
        
         button.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}
