//
//  Manager.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/8/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit

class Manager: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    let sectionsIdentifiers: [String] = ["managePolls", "manageScores", "salaries", "donationRequests", "contactMembers", "plansStrategies", "courtReservations", "schedule", "attendance", "bookServices", "updateHistory", "manageMedia", "manageTickets", "updateTeamMembers", "Update Personal Information"]
    
    let sectionsNames: [String] = ["Manage Polls", "Manage Scores", "Salaries", "Donation Requests", "Contact Other Members", "Plans and Strategies", "Manage Court Reservations", "Edit Schedule", "Attendance", "Book Services", "Update History Information", "Manage Media", "Manage Tickets", "Team Members", "Update Personal Information"]

    @IBAction func logOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
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
