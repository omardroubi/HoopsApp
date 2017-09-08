//
//  AddTickets.swift
//  Hoops
//
//  Created by Omar Droubi on 12/13/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase

class AddTickets: UIViewController, UITextFieldDelegate {
    
    var ticketRef = FIRDatabase.database().reference().child("Tickets")
   
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


    @IBAction func done(_ sender: Any) {
        var complete = true
        
        if ((eventinfo.text!=="") || (eventname.text!=="") || (vip.text!=="") || (regular.text!=="") || (pvip.text!=="") || (pregular.text!=="") || (available.text!=="")) {
            complete = false
            
        }
        
        if (complete){
        
            let eventid = arc4random_uniform(100000)
            
            let newevent = ticketstruct(eventname: eventname.text!, eventinfo: eventinfo.text!, eventid: Int(eventid), numbervip: Int(vip.text!)!, numberregular: Int(regular.text!)!, pricevip: Int(pvip.text!)!, priceregular: Int(pregular.text!)!, available: Bool(available.text!)!)
            
            
            
            let ticketRef = self.ticketRef.child("\(eventid)")
            
            ticketRef.setValue(newevent.toAnyObject())
            
            dismiss(animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Incomplete Form", message: "Please fill all the fields before clicking Done", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            complete = true
        }
    }
    
    @IBOutlet var eventname: UITextField!
    @IBOutlet var eventinfo: UITextField!
    
    @IBOutlet var vip: UITextField!
    @IBOutlet var regular: UITextField!
    @IBOutlet var pvip: UITextField!
    
    @IBOutlet var pregular: UITextField!
    
    @IBOutlet var available: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        eventname.delegate = self
        eventinfo.delegate = self
        vip.delegate = self
        regular.delegate = self
        pvip.delegate = self
        pregular.delegate = self
        available.delegate = self
   

        

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
