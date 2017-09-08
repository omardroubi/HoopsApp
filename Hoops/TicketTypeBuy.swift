//
//  TicketTypeBuy.swift
//  

//  Created by Vanessa Nader and Omar Droubi
//  EECE 430 American University of Beirut
//  HOOPS APP

import UIKit


//this class helps the user choose what kind of ticket he wants: VIP or Regular and sends him to the right scene after his choice
class TicketTypeBuy: UIViewController {

    @IBAction func cancelEvent(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    } //dimiss the current scene
    
    var event: ticketstruct = ticketstruct(eventname: "", eventinfo: "", eventid: 0, numbervip: 0, numberregular: 0, pricevip: 0, priceregular: 0, available: false) //create a ticket object for the segue

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)   {
        if segue.identifier == "toRegular" { //define to which scene we go next depending on if the user chose to buy regular tickets or VIP tickets
         
            let guest = segue.destination as! TicketOrder
            guest.event = event
            guest.chosentype = "Regular"

        }
        if segue.identifier == "toVIP" {
            let guest = segue.destination as! TicketOrder
            guest.event = event
            guest.chosentype = "VIP"
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
