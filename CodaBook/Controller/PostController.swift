//
//  PostController.swift
//  CodaBook
//
//  Created by Riad Korimbacus on 02/06/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit
import FirebaseAuth

class PostController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoDuPost: UIImageView!
    
    @IBOutlet weak var texteDuPost: UITextView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        texteDuPost.text = TEXTE_VIDE
        texteDuPost.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rangerClavier)))
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    @objc func rangerClavier() {
        
        view.endEditing(true)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if texteDuPost.text == TEXTE_VIDE {
            texteDuPost.text = ""
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editee = info[UIImagePickerControllerEditedImage] as? UIImage {
            photoDuPost.image = editee
        } else if let originale = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoDuPost.image = originale
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photoAction(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func librairieAction(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
   
    @IBAction func envoyerPostDansBDD(_ sender: Any) {
        
        view.endEditing(true)
        guard let id = Auth.auth().currentUser?.uid else { return }
        if texteDuPost.text == TEXTE_VIDE || texteDuPost.text == "" {
            Alerte.montrer.erreur(message: VIDE, controller: self)
        } else {
            var dict: [String: AnyObject] = [
                TEXTE: texteDuPost.text as AnyObject,
                DATE_POST: Date().timeIntervalSince1970 as AnyObject,
                USER_ID: id as AnyObject
            ]
            if let image = photoDuPost.image, let data = UIImageJPEGRepresentation(image, 0.3) {
                let unique = UUID().uuidString
                let ref = Refs.obtenir.basePhotoDuPost.child(id).child(unique)
                ref.putData(data, metadata: nil, completion: { (metadata, error) in
                    if error == nil {
                        ref.downloadURL(completion: { (url, error) in
                            if let urlString = url?.absoluteString {
                                dict[IMAGE_URL] = urlString as AnyObject
                                self.envoyerPostSurFirebase(dict: dict)
                            }
                        })
                    } else {
                        print(error!.localizedDescription)
                    }
                })
            } else {
                envoyerPostSurFirebase(dict: dict)
            }
        }
    }
    
    func envoyerPostSurFirebase(dict:[String: AnyObject]) {
        
        let ref = Refs.obtenir.basePost.childByAutoId()
        ref.updateChildValues(dict)
        navigationController?.popViewController(animated: true)
    }
    
}
