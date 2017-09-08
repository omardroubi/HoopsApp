//
//  Coach.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/8/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit

class Player: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func logOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    let sectionsNames: [String] = ["View Payments", "Update Personal Information", "Contact Other Members", "View Line Ups", "View Plans", "Schedule", "CHECK-IN", "Diet Plan", "Workout"]
    
    let sectionsIdentifiers: [String] = ["viewSalary", "updatePlayerInfo", "contactOtherMembers", "lineUps", "viewPlans", "schedule", "checkIn", "dietPlan", "workout"]
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: sectionsIdentifiers[indexPath.row])
        
        cell.textLabel?.text = sectionsNames[indexPath.row]
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sectionsIdentifiers.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: sectionsIdentifiers[indexPath.row], sender: sectionsIdentifiers[indexPath.row])
    }
    
    
}
