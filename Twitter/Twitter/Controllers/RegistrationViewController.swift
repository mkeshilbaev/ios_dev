//
//  RegistrationViewController.swift
//  Twitter
//
//  Created by Madi Keshilbayev on 08.04.2021.
//  Copyright © 2021 Madi Keshilbayev. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class RegistrationViewController: UIViewController {

    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var birth_date: UITextField!
    @IBOutlet weak var email_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    @IBOutlet weak var confirm_password_field: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let storageRef = Storage.storage().reference(forURL: "gs://twitter-8eeb6.appspot.com/")

    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupAvatar()
    }
    
//    func setupAvatar(){
//        avatar.layer.cornerRadius = avatar.frame.size.width / 2
//        avatar.clipsToBounds = true
//        avatar.isUserInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
//        avatar.addGestureRecognizer(tapGesture)
//    }
    
    @objc func presentPicker(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }

    
    @IBAction func register_clicked(_ sender: UIButton) {
//        guard let imageSelected = self.image else{ print("Avatar is nil"); return }
//        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else{ return }
        
        guard let name = name.text else { return }
        guard let surname = surname.text else { return }
        guard let email = email_field.text else { return }
        guard let password = password_field.text else { return }
        guard let birth_date = birth_date.text else { return }
//        var profile_image_url: String = ""

                
        if email != "" && password != ""{
            indicator.startAnimating()
           
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
              
                self?.indicator.stopAnimating()
                
                Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                
                if error == nil{
                    
//                    let storageProfileRef = self!.storageRef.child("users").child(Auth.auth().currentUser!.uid)
//
//                    let metadata = StorageMetadata()
//                    metadata.contentType = "image/jpg"
//
//                    self!.storageRef.putData(imageData , metadata: metadata, completion: {(storageMetaData, error) in
//                        if(error != nil){
//                            print(error?.localizedDescription)
//                            return
//                        }
//                        storageProfileRef.downloadURL(completion: {(url, error) in
//                            if let metaImageUrl = url?.absoluteString{
//                                print(metaImageUrl)
//                                profile_image_url = metaImageUrl
//                            }
//                        })
//                    })
                    
                    Database.database(url:"https://twitter-8eeb6-default-rtdb.europe-west1.firebasedatabase.app").reference().child("users").child((result?.user.uid)!).setValue(["name": name, "surname": surname, "email": email, "birth_date": birth_date])
                                        
                    self?.showMessage(title: "Success", message: "Please verify your email")
                }
                else{
                    self?.showMessage(title: "Error", message: "Couldn't sign up the user!")
                }
            }
        }
    }
    
    func showMessage(title: String, message: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //add and action (button)
        let ok = UIAlertAction(title: "OK", style: .default){ (UIAlertAction) in
            if title != "Error"{
                self.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(ok)
        
        //show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            image = imageSelected
            avatar.image = imageSelected
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            image = imageOriginal
            avatar.image = imageOriginal
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
