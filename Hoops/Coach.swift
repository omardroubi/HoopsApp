//
//  Coach.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/8/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit

class Coach: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBAction func logOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    let sectionsNames: [String] = ["View Salary", "Contact Other Members", "Upload Line Up", "Upload Plans", "Schedule", "View Attendance", "Upload Diet Plan", "Upload Workout", "Poll Statistics", "Update Personal Information"]

    let sectionsIdentifiers: [String] = ["viewSalary", "contactOtherMembers", "uploadLineUp", "uploadPlans", "schedule", "viewAttendance", "uploadDietPlan", "uploadWorkout", "pollStatistics", "Update Personal Information"]

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
