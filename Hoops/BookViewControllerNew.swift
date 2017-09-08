//
//  ViewController.swift
//  Book
//
//  Created by Vanessa Nader on 11/28/16.
//  Copyright © 2016 Vanessa Nader. All rights reserved.
//

import UIKit

class BookViewControllerNew: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var table: UITableView!
    let bookings = ["Flights", "Hotels", "Restaurants", "Transportation"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookings.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookcell = Bundle.main.loadNibNamed("BookCell", owner: self, options: nil)?.first as! BookCell
        bookcell.imageBackground.image = UIImage(named : "\(bookings[indexPath.row]).jpg")
        bookcell.title?.text = bookings[indexPath.row]
        return bookcell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToWebPage", sender: bookings[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let guest = segue.destination as! WebBooking
        guest.booking = sender as! String
    }
    
}

