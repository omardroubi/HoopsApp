//
//  ContactUs.swift
//  Hoops
//
//  Created by Omar Droubi on 11/24/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation
import MapKit

class ContactUs : UIViewController, MKMapViewDelegate {
    
    @IBOutlet var menu: UIBarButtonItem!
    
    
    @IBOutlet var map: MKMapView!
    
    @IBOutlet var image: UIImageView!
    
    override func viewDidLoad() {
      
        menu.target = self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))

        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    
        
        let latitude: CLLocationDegrees = 33.8484798
        
        let longitude: CLLocationDegrees = 35.4920921
        
        let latDelta: CLLocationDegrees = 0.03
        
        let lonDelta: CLLocationDegrees = 0.03
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        map.setRegion(region, animated: true)
        
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        dropPin.title = "Hoops Team Stadium"
        map.addAnnotation(dropPin)
        
        
        self.image.image = UIImage(named: "Screen Shot 2016-11-25 at 4.31.16 AM")
    }
    
}
