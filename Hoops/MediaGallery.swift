//
//  MediaGallery.swift
//  Hoops
//
//  Created by Omar Droubi on 11/24/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import Foundation
import Firebase

class MediaGallery: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var menu: UIBarButtonItem!
    var images: [UIImage] = []
    
    var photoList : [mediafile] = []
    @IBOutlet var table: UITableView!
  
    var photoRef: FIRDatabaseReference!
    var photostorageRef : FIRStorageReference!
    
    
    var photoRefwrite = FIRDatabase.database().reference().child("Media")
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)

        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        menu.target = self.revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        // read the databse for Polls
        photoRef = FIRDatabase.database().reference()
        photoRef.child("Media").queryOrderedByKey().observe(.childAdded, with: {
            
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let file = snapshotValue!["File Name"] as! String
            let imagereference = snapshotValue!["Media"] as! String
            
            let newPhoto: mediafile = mediafile(filename: file, mediaurl: imagereference)
            self.photoList.append(newPhoto)
            
            self.table.reloadData()
            
        })
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MediaCell = table.dequeueReusableCell(withIdentifier: "cell", for : indexPath) as! MediaCell
        
        cell.name.text = photoList[indexPath.row].filename
        
        photostorageRef = FIRStorage.storage().reference(forURL: photoList[indexPath.row].mediaurl)
        photostorageRef.data(withMaxSize: 1*1024*1024, completion: {(data, error) in
            if error == nil {
                if let data = data {
                    cell.mediaimage.image = UIImage(data: data)
                }
            } else {
                //
            }
            
            
        })
        cell.name.sizeToFit()
        cell.sizeToFit()
        return cell
    }

}
