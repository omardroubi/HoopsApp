//
//  Payment.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/7/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit

class Payment: UIViewController {

    var name = "anything"
    var email = "anything"
    var donationamount = 0
    var comment = ""

    


    
    @IBAction func cancelEvent(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)   {
        if segue.identifier == "toCreditCard" {
            let credit = segue.destination as! CreditCardPayment
            credit.name = name
            credit.email = email
            credit.donationamount = donationamount
            credit.comment = comment
        }
        if segue.identifier == "toCash" {
            let cash = segue.destination as! CashPayment
            cash.name = name
            cash.email = email
            cash.donationamount = donationamount
            cash.comment = comment
        }

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
