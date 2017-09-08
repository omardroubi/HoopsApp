//
//  Team.swift
//  Hoops
//
//  Created by Omar Droubi on 11/24/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation

class Team : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var menu: UIBarButtonItem!
    
    @IBOutlet var table: UITableView!
    
    let bookings = ["History", "Statistics", "Members", "Awards"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        menu.target = self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookings.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bookcell = Bundle.main.loadNibNamed("TeamCell", owner: self, options: nil)?.first as! TeamCell
        
        bookcell.imageBackground.image = UIImage(named : "\(bookings[indexPath.row]).jpg")
        
        return bookcell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: bookings[indexPath.row], sender: bookings[indexPath.row])
    }
    
    
}









