//
//  CreditCardPayment.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/10/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreditCardPayment: UIViewController, UITextFieldDelegate {
    
    var donationRef = FIRDatabase.database().reference().child("Donation Requests")
    
    var name = "anything"
    var email = "anything"
    var donationamount = 0
    var comment = ""
    var methodofpayment = "Credit Card"
    let receiptnumber = arc4random_uniform(100000)

    @IBOutlet weak var donationnumber: UILabel!
    @IBOutlet weak var cardnumber: UITextField!
    
    @IBOutlet weak var cardmonth: UITextField!
    
    @IBOutlet weak var cardyear: UITextField!
    
    @IBOutlet weak var cvc: UITextField!
    
    
    
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func confirm(_ sender: Any) {
        let date = Date()
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        
        if (cardnumber.text == ""){
            let alert = UIAlertController(title: "Card number missing", message: "Please enter your card number", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else if (cardnumber.text!.characters.count != 16)
        {
            let alert = UIAlertController(title: "Card number wrong format", message: "Please enter your card number. It's a 16 digit number found at the front of the card", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        else if (cardmonth.text == "" ) {
            let alert = UIAlertController(title: "Expiry month missing", message: "Please enter your card's expiry date month", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        else if (cardyear.text == ""){
            let alert = UIAlertController(title: "Expiry year missing", message: "Please enter your card's expiry date year", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }  else if (Int(cardyear.text!)! == year){
            if (Int(cardmonth.text!)! < month) {
                let alert = UIAlertController(title: "Invalid card", message: "Please use a credit card that is not expired", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            }
        }
            else if (Int(cardyear.text!)! < year || Int(cardmonth.text!)! > 12) {
                let alert = UIAlertController(title: "Invalid card", message: "Please use a credit card that is not expired", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
            
        
        else if (cvc.text == ""){
            let alert = UIAlertController(title: "CVC missing", message: "Please enter your card's CVC found at the back of the card", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else if (cvc.text!.characters.count != 3)
        {
            let alert = UIAlertController(title: "CVC wrong format", message: "Please enter your card's CVC found at the back of the card. It's a 3 digit number", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
         
        else {

        
        let newdonation = donation(name: name, email: email, donationamount : donationamount, comments: comment, methodofpayment: methodofpayment, status: false, receiptnumber: Int(receiptnumber) )
        let donationRef = self.donationRef.child("\(receiptnumber)")
        
        donationRef.setValue(newdonation.toAnyObject())
        
        
        
        dismiss(animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cardnumber.delegate = self
        cardmonth.delegate = self
        cardyear.delegate = self
        cvc.delegate = self
        donationnumber.text = "\(donationamount)"


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        cardnumber.resignFirstResponder()
        cardmonth.resignFirstResponder()
        cardyear.resignFirstResponder()
        cvc.resignFirstResponder()
        return true
        
    }
    


}
