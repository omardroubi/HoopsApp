//
//  CheckIn.swift
//  Hoops
//
//  Created by Omar Droubi on 12/11/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class CheckIn: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    var personsList = [Person]()
    
    @IBOutlet var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var name = ""
    
    var counter = 0
    
    //DATABASE
    var eventRefAdd = FIRDatabase.database().reference().child("Attendance List")
    var eventRef: FIRDatabaseReference!
    
    
    
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)
        
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
        
        
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization();
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        else{
            print("Location service disabled");
        }
        
        
        
    }
    
    func locationManager(locationManager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation // note that locations is same as the one in the function declaration
        
        locationManager.stopUpdatingLocation() // to stop putting the screen in the middle
        
        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        
        let latDelta: CLLocationDegrees = 0.03
        
        let lonDelta: CLLocationDegrees = 0.03
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let region = MKCoordinateRegion(center: coordinations, span: span)//this basically tells your map where to look and where from what distance
        
        map.setRegion(region, animated: true)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    @IBAction func checkInButton(_ sender: Any) {
        
        var locManager = CLLocationManager()
        var currentLocation: CLLocation!
        
        locManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
        }
        
        //Latitude 33.8484798
        //Longitude 35.4920921
        
        // SUCCESS
        if (currentLocation.coordinate.latitude > 33.84 && currentLocation.coordinate.longitude > 35.49 && currentLocation.coordinate.latitude < 33.86 && currentLocation.coordinate.longitude < 35.6) {
            
            let alert = UIAlertController(title: "Successfully Checked In!", message: "Your attendance will be sent to the manager and the coach", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            
            // READ FROM Database to get his name
            eventRef = FIRDatabase.database().reference()
            eventRef.child("Players").queryOrderedByKey().observe(.childAdded, with: {
                
                snapshot in
                var snapshotValue = snapshot.value as? NSDictionary
                let name = snapshotValue!["Name"] as! String
                let email = snapshotValue!["Email"] as! String
                let password = snapshotValue!["Password"] as! String
                let personalInfo = snapshotValue!["Personal Information"] as! String
                var salary = snapshotValue!["Salary"] as! Int
                
                
                var addToList = Person(name: name, email: email, password: password, role: "Player", salary: salary, personalInfo: personalInfo)
                
                
                self.personsList.append(addToList)
                
                
                let userEmail = FIRAuth.auth()?.currentUser?.email!
                
                print(userEmail)
                
                // ADD TO DATABASE
                let date = NSDate()
                
                for person in self.personsList {
                    print(person.email)
                    if userEmail == person.email {
                        print(person.email)
                        let eventRefAdd = self.eventRefAdd.child(person.name).child(date.description)
                        
                        
                        
                        
                        eventRefAdd.setValue(["Date": date.description])
                    }
                }
                
                
                
            })
            
            
            // FAIL
        } else {
            let alert = UIAlertController(title: "Wrong Location!", message: "Please go to the training field in order to check in", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
    }
    
    
}
