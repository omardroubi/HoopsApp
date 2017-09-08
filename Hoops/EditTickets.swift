//
//  EditTickets.swift
//  Hoops
//
//  Created by Omar Droubi on 12/13/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase

//this class helps the manager edit already existing tickets in the database
class EditTickets: UIViewController, UITextFieldDelegate {
    
var ticketRef = FIRDatabase.database().reference().child("Tickets") //create a reference to the Tickets category in the database
    
    
 var event: ticketstruct = ticketstruct(eventname: "", eventinfo: "", eventid: 0, numbervip: 0, numberregular: 0, pricevip: 0, priceregular: 0, available: false) //create an event object for the segue
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil) //dismiss the current scene
    }
    
    @IBAction func done(_ sender: Any) {
        var complete = true
        
        if ((eventinfo.text!=="") || (eventname.text!=="") || (vip.text!=="") || (regular.text!=="") || (pvip.text!=="") || (pregular.text!=="") || (available.text!=="")) {
            complete = false
            
        } //check if all the text fields are filled
        
        if (complete){
            
            
            let newevent = ticketstruct(eventname: eventname.text!, eventinfo: eventinfo.text!, eventid: event.eventid, numbervip: Int(vip.text!)!, numberregular: Int(regular.text!)!, pricevip: Int(pvip.text!)!, priceregular: Int(pregular.text!)!, available: Bool(available.text!)!)
            //create a new ticket struct object
            
            
            let ticketRef = self.ticketRef.child("\(event.eventid)") //reference to the object
            
            ticketRef.setValue(newevent.toAnyObject()) //store the edited object in the right path in the database after converting it into a dictionary
            
            dismiss(animated: true, completion: nil)
        }
        else { //display an alert if at least one of the text fields is empty
            let alert = UIAlertController(title: "Incomplete Form", message: "Please fill all the fields before clicking Done", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            complete = true
        }

    }

    
    @IBOutlet var eventname: UITextField! // link the text fields to the code
    @IBOutlet var eventinfo: UITextField!
    @IBOutlet var vip: UITextField!
    @IBOutlet var regular: UITextField!
    @IBOutlet var pvip: UITextField!
    @IBOutlet var pregular: UITextField!
    @IBOutlet var available: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        eventname.delegate = self //set the class to be the delegate of the textfields
        eventinfo.delegate = self
        vip.delegate = self
        regular.delegate = self
        pvip.delegate = self
        pregular.delegate = self
        available.delegate = self
        
        
        eventname.text = event.eventname //display the values on the labels
        eventinfo.text = event.eventinfo
        vip.text = String(event.numbervip)
        regular.text = String(event.numberregular)
        pvip.text = String(event.pricevip)
        pregular.text = String(event.priceregular)
        available.text = String(event.available)
        
        
        
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
        
        eventname.resignFirstResponder()
        eventinfo.resignFirstResponder()
        vip.resignFirstResponder()
        regular.resignFirstResponder()
        pvip.resignFirstResponder()
        pregular.resignFirstResponder()
        available.resignFirstResponder()
        return true
        
    }

   

}
