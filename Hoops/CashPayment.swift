//
//  CashPayment.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/10/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class CashPayment: UIViewController {
    
    var name = "anything"
    var email = "anything"
    var donationamount = 0
    var comment = ""
    var methodofpayment = "Cash"
    
    var donationRef = FIRDatabase.database().reference().child("Donation Requests")
    

    @IBOutlet weak var receiptnumber: UILabel!
    @IBOutlet weak var donorname: UILabel!
    @IBOutlet weak var donoremail: UILabel!
    
    @IBOutlet weak var donationnumber: UILabel!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func done(_ sender: Any) {
        
        let newdonation = donation(name: name, email: email, donationamount : donationamount, comments: comment, methodofpayment: methodofpayment, status: false, receiptnumber: Int(receiptnumber.text!)! )
        let donationRef = self.donationRef.child(receiptnumber.text!)
        
        donationRef.setValue(newdonation.toAnyObject())
        

        
        dismiss(animated: true, completion: nil)

        
        
        
    }
    override func viewDidLoad() {
        receiptnumber.text = "\(arc4random_uniform(100000))"
        donorname.text = name
        donoremail.text = email
        donationnumber.text = "\(donationamount)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
