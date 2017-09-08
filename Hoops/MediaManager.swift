//
//  MediaManager.swift
//  Hoops
//
//  Created by Vanessa Nader on 12/12/16.
//  Copyright © 2016 Omar Droubi. All rights reserved.
//

import UIKit
import Firebase

class MediaManager: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var table: UITableView!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    var photoList : [mediafile] = []
    var photoRef: FIRDatabaseReference!
    var photostorageRef : FIRStorageReference!
    
    
    var photoRefwrite = FIRDatabase.database().reference().child("Media")
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Simple iPhone 6 Wallpaper 200.jpg")!)

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
        let cell : PhotoCell = table.dequeueReusableCell(withIdentifier: "cell", for : indexPath) as! PhotoCell
        
        cell.event.text = photoList[indexPath.row].filename
        
        photostorageRef = FIRStorage.storage().reference(forURL: photoList[indexPath.row].mediaurl)
        photostorageRef.data(withMaxSize: 1*1024*1024, completion: {(data, error) in
            if error == nil {
                if let data = data {
                    cell.imageused.image = UIImage(data: data)
                }
            } else {
                //
            }
            
            
        })
        cell.event.sizeToFit()
        cell.sizeToFit()
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            photoRefwrite.child(photoList[indexPath.row].filename).removeValue()
            let storage = FIRStorage.storage()
            let storageRef = storage.reference(forURL: "gs://hoopsclub-b917e.appspot.com")
            let storageref = storageRef.child("media/\(photoList[indexPath.row].filename)/mediaimage")
            storageref.delete(completion: { (error) in
                if error == nil {
                    self.photoList.remove(at: indexPath.row)
                    self.table.reloadData()
                } else {
                    print (error!)
                }
            })
            table.reloadData()
            
        }
        
    }
}


