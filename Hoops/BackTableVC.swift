//
//  BackTableVC.swift
//  Hoops
//
//  Created by Omar Droubi on 11/22/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation

class BackTableVC: UITableViewController {
    
    var tableArray = [String]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)

    }

    override func viewDidLoad() {
        tableArray = ["Home", "Team", "Ticket Store", "Court Reservations", "Schedule", "Media Gallery", "Feedback", "Polls", "Donate", "Contact Us", "Log In", "Test"]
        
        let tempImageView = UIImageView(image: UIImage(named: "salaryBackground"))
        tempImageView.contentMode = .scaleAspectFill
        tempImageView.frame = self.tableView.frame
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        //Depending on your image, it might look better to use UIBlurEffect(style: UIBlurEffectStyle.ExtraLight) or UIBlurEffect(style: UIBlurEffectStyle.Dark).
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tempImageView.bounds
        
        tempImageView.addSubview(blurView)
        self.tableView.backgroundView = tempImageView;
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: tableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        cell.backgroundColor = .clear
        //cell.backgroundColor = UIColor(white: 1, alpha: 0.5)

        cell.textLabel?.text = tableArray[indexPath.row]
        
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
}
