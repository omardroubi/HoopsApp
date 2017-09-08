//
//  TicketOrder.swift
//  

//  Created by Vanessa Nader and Omar Droubi
//  EECE 430 American University of Beirut
//  HOOPS APP

import UIKit


//this class helps us set the payment information such as the buyer's name, the buyer's email and the number of tickets he would like to purchase
class TicketOrder: UIViewController, UITextFieldDelegate {
    
    var check: Bool = false //we will this check for the segue to make sure we have all the elements we need to move on with the transaction
    
    @IBAction func proceed(_ sender: Any) {
        if (email.text! == "" || fullName.text! == "" || numberOfTickets.text == "") { //if any of the text fields are empty, we have missing information and the app should block the continuation of the transaction until the text fields are filled
            let alert = UIAlertController(title: "Incomplete form", message: "Please fill all the fields in order to proceed", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            

        } else if  (!email.text!.contains("@") || !email.text!.contains(".com")) { //check if the email entered has a valid format
            let alert = UIAlertController(title: "Incorrect Email", message: "Please enter a valid email", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            check = true // if all of the conditions are met, the app can continue with the transaction
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)   { //prepare for the continuation of the transaction
        if (email.text! == "" || fullName.text! == "" || numberOfTickets.text == "") {// same checks as before
            let alert = UIAlertController(title: "Incomplete form", message: "Please fill all the fields in order to proceed", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            
        } else if  (!email.text!.contains("@") || !email.text!.contains(".com")) {
            let alert = UIAlertController(title: "Incorrect Email", message: "Please enter a valid email", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }else {
            if segue.identifier == "toChoose" { //identify the segue that will lead to the next scene
            let guest = segue.destination as! TicketPaymentMethod //set the destination for the next scene
            guest.event = self.event //pass values for the next scene to come
            guest.chosentype = self.chosentype
            guest.fullName = self.fullName.text!
            guest.email = self.email.text!
            guest.numberOfTickets = Int(self.numberOfTickets.text!)!
        }
        
    }

        }
    
    
    
    
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil) //dismiss the scene
    }
    @IBOutlet var email: UITextField!
    @IBOutlet var fullName: UITextField!
    @IBOutlet var numberOfTickets: UITextField!
    var event: ticketstruct = ticketstruct(eventname: "", eventinfo: "", eventid: 0, numbervip: 0, numberregular: 0, pricevip: 0, priceregular: 0, available: false) //create a ticket object for the segue

    var chosentype = "" //create a chosen type string for the segue
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        fullName.delegate = self
        numberOfTickets.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true) //dimiss the keyboard if the user touches outside
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        email.resignFirstResponder() //dismiss the keyboard when the user pressed the return key
        fullName.resignFirstResponder()
        numberOfTickets.resignFirstResponder()
        return true
        
    }

}
