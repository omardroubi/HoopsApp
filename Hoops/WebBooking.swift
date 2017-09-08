//
//  WebBooking.swift
//  Book
//
//  Created by Vanessa Nader on 11/28/16.
//  Copyright © 2016 Vanessa Nader. All rights reserved.
//

import UIKit

class WebBooking: UIViewController {

    @IBOutlet weak var webpage: UIWebView!
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    var booking = "anything"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch booking{
        case "Flights":
            let url = URL (string: "https://www.expedia.com/m/flights")!
            webpage.loadRequest(URLRequest(url : url))
        case "Hotels":
            let url = URL (string: "https://www.expedia.com/MobileHotel")!
            webpage.loadRequest(URLRequest(url : url))
        case "Restaurants":
            let url = URL (string: "https://m.opentable.com")!
            webpage.loadRequest(URLRequest(url : url))
        case "Transportation":
            let url = URL (string: "https://www.busbank.com")!
            webpage.loadRequest(URLRequest(url : url))
        default: break
            
        }
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
