//
//  Login.swift
//  Hoops
//
//  Created by Omar Droubi on 11/24/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import Firebase

class Login : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var managerloginsuccess = false
    var coachloginsuccess = false
    var playerloginsuccess = false
    
    //let dbRef = FIRDatabase.database().reference().child("Active Users")
    
    @IBOutlet var menu: UIBarButtonItem!
    
    override func viewDidLoad() {
        // Edit the placeholders in the textfield (Color + Keyboard Next)
        let placeholder1 = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName:UIColor.white])
        
        let placeholder2 = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName:UIColor.white])
        
        email.attributedPlaceholder = placeholder1
        password.attributedPlaceholder = placeholder2
        

                
        menu.target = self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        email.delegate = self
        password.delegate = self
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        email.resignFirstResponder()
        password.resignFirstResponder()
        return true
        
    }
    
    
    
    @IBAction func managerLogIn(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!, completion: {
            
            user, error in
            
            if error != nil {
                let alert = UIAlertController(title: "Login error", message: "Email/Password combination incorrect.", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            } else {
                print ("Login was ok")
                let activeuser = FIRAuth.auth()?.currentUser
                let mail = activeuser?.email
                if (mail?.contains("manager"))!{
                    print ("all good")
                    self.managerloginsuccess = true
                } else {
                    let alert = UIAlertController(title: "Login error", message: "Manager log in denied. Please sign in to your appropriate section.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                if self.managerloginsuccess {
                    self.managerloginsuccess = false
                    
                    self.performSegue(withIdentifier: "toManager", sender: nil)
                    print ("went to manager")
                }
                
                
            }
            
            
        })
        
    }
    
    
    
    @IBAction func coachLogIn(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!, completion: {
            
            user, error in
            
            if error != nil {
                let alert = UIAlertController(title: "Login error", message: "Email/Password combination incorrect.", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            } else {
                print ("Login was ok")
                let activeuser = FIRAuth.auth()?.currentUser
                let mail = activeuser?.email
                if (mail?.contains("coach"))!{
                    print ("all good")
                    self.coachloginsuccess = true
                } else {
                    let alert = UIAlertController(title: "Login error", message: "Coach log in denied. Please sign in to your appropriate section.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                if self.coachloginsuccess {
                    self.coachloginsuccess = false
                    self.performSegue(withIdentifier: "toCoach", sender: nil)
                    print ("went to coach")
                    
                }
                
            }
            
        })
        
        
        
    }
    
    
    
    @IBAction func playerLogIn(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!, completion: {
            
            user, error in
            
            if error != nil {
                let alert = UIAlertController(title: "Login error", message: "Email/Password combination incorrect.", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            } else {
                print ("Login was ok")
                let activeuser = FIRAuth.auth()?.currentUser
                let mail = activeuser?.email
                if (mail?.contains("player"))!{
                    print ("all good")
                    self.playerloginsuccess = true
                } else {
                    let alert = UIAlertController(title: "Login error", message: "Player log in denied. Please sign in to your appropriate section.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                if self.playerloginsuccess {
                    self.playerloginsuccess = false
                    self.performSegue(withIdentifier: "toPlayer", sender: nil)
                    print ("went to player")
                    
                }
                
            }
            
        })
        
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "toManager"{
                if managerloginsuccess != true {
                    return false
                }
                
            }
            else if (ident == "toCoach") {
                if coachloginsuccess != true {
                    return false
                }
            }
            else if (ident == "toPlayer"){
                if playerloginsuccess != true {
                    return false
                }
            }
        }
        return true
    }
    
}


