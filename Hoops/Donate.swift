//
//  Donate.swift
//  Hoops
//
//  Created by Omar Droubi on 11/24/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation

class Donate : UIViewController, UITextFieldDelegate {
    

    
    @IBOutlet weak var menu: UIBarButtonItem!
 
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var commentsTextField: UITextField!
    
    var actualcomment = ""
    var actualamount = 0
    
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        menu.target = self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        amountTextField.delegate = self
        commentsTextField.delegate = self
    }
    
    // to remove keyboard when finished writing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        amountTextField.resignFirstResponder()
        commentsTextField.resignFirstResponder()
        return true
        
    }
    
    @IBAction func goToPayment(_ sender: AnyObject) {
        
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if commentsTextField.text != nil {
                self.actualcomment = commentsTextField.text!
                
            } else {
                self.actualcomment = "No comments"
            }
            if (nameTextField.text == ""){
                let alert = UIAlertController(title: "Name missing", message: "Please enter your full name under Full Name", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
            if (emailTextField.text == "" ) {
                let alert = UIAlertController(title: "Email missing", message: "Please enter your email address under Email address", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
            if (amountTextField.text == ""){
                let alert = UIAlertController(title: "Donation amount error", message: "Please enter the amount of money in USD that you want to donate under Donation amount", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            } else {
                actualamount = Int(amountTextField.text!)!
            }
            if (!(emailTextField.text!.contains("@")) || !(emailTextField.text!.contains(".com"))){
                let alert = UIAlertController(title: "Email format error", message: "Please enter a valid email under Email address", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }

        
                let payment = segue.destination as! Payment
                payment.name = nameTextField.text!
                payment.email = emailTextField.text!
                payment.donationamount = actualamount
                payment.comment = actualcomment
                
                

            }
        
    
    
    
    
}
