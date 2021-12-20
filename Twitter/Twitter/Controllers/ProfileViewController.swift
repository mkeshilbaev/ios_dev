//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Madi Keshilbayev on 17.04.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var profile_picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    
    var current_user: User?
    var databaseRef = Database.database(url: "https://twitter-8eeb6-default-rtdb.europe-west1.firebasedatabase.app").reference()
    var storageRef = Storage.storage().reference()
    var imagePicker = UIImagePickerController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        current_user = Auth.auth().currentUser!
        let userID = current_user?.uid
        
        databaseRef.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
          self.name.text = value?["name"] as? String ?? "Error"
          self.username.text = value?["email"] as? String ?? "Error"
          

            if (value?["profile_picture"] != nil){
                let databaseProfilePic = value?["profile_picture"] as! String
                let data = NSData(contentsOf: NSURL(string: databaseProfilePic) as! URL)
                self.setProfilePicture(imageView: self.profile_picture, imageToSet: UIImage(data:data! as Data)!)
            }
        
        
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    @IBAction func didTapProfilePicture(_ sender: UITapGestureRecognizer) {
        let myActionSheet = UIAlertController(title: "Profile picture", message: "Select", preferredStyle: .actionSheet)
        
        let viewPicture = UIAlertAction(title: "View picture", style: .default) { (action) in
            let imageView = sender.view as! UIImageView
            let newImageView = UIImageView(image: imageView.image)
            newImageView.frame = self.view.frame
            newImageView.backgroundColor = UIColor.black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullScreenImage))
            
            newImageView.addGestureRecognizer(tap)
            self.view.addSubview(newImageView)
        }
        
        let photoGallery = UIAlertAction(title: "Photos", style: .default){ (action) in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        myActionSheet.addAction(viewPicture)
        myActionSheet.addAction(photoGallery)
        
        myActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: nil))
        
        self.present(myActionSheet, animated: true, completion: nil)
    }
    
    
    @objc func dismissFullScreenImage(sender: UITapGestureRecognizer){
        //remove the larger image from the view
        sender.view?.removeFromSuperview()
    }
    
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any], image: UIImage ) {
//
//        setProfilePicture(imageView: self.profile_picture, imageToSet: image)
//
//        if let imageData = profile_picture.image?.pngData() {
//
//        let profilePicStorageRef = storageRef.child("users/\(current_user!.uid)/profile_picture")
//
//            let uploadTask = profilePicStorageRef.putData(imageData as Data, metadata: nil){ metadata, error in
//
//                if (error == nil){
////                    self.storageRef.downloadURL(completion: {(url,error) in
////                        if let metaImageUrl = url?.absoluteString{
////                        print(metaImageUrl)
////                        }
////                    })
//                    let downloadUrl = metadata!.downloadURL()
//                  self.databaseRef.child("users").child(current_user?.uid).child("profile_picture").setValue(downloadUrl!.absoluteString)
//                }
//                else{
//                    print(error?.localizedDescription)
//                    print("Error while uploading profile picture in to storage !!!!!!!!!!!!!!!!!!!!")
//                }
//            }
//
//        }
//    }
    
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        do{
        try Auth.auth().signOut()
        }catch{
            print("Error while sign out!")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    internal func setProfilePicture(imageView: UIImageView, imageToSet: UIImage){
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        imageView.image = imageToSet
    }

}
