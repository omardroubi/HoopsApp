import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
       
       
        
        FIRDatabase.database().persistenceEnabled = true
        
        /*
        FIRAuth.auth()?.signIn(withEmail: "omardroubi@live.com", password: "facebook", completion: { (user: FIRUser?, error: Error?) in
            if (error == nil) {
                print("Successful, the email is: " + (user?.email)!)
            
            } else {
                print(error);
            }
            })
        */
        
        return true
    }
    
    override init(){
        super.init()
         FIRApp.configure()
    }
}
