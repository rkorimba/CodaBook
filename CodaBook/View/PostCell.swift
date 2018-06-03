//
//  PostCell.swift
//  CodaBook
//
//  Created by Riad Korimbacus on 03/06/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class PostCell: UITableViewCell {

    @IBOutlet weak var photoDeProfil: ImageRonde!
    @IBOutlet weak var nomEtPrenom: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageDuPost: UIImageView!
    @IBOutlet weak var texteDuPost: UILabel!
    @IBOutlet weak var boutonLike: UIButton!
    @IBOutlet weak var nombreDeLikes: UILabel!
    
    var post: Post!
    
    func miseEnPlace(post: Post) {
        
        self.post = post
        photoDeProfil.telecharger(self.post.utilisateur.imageUrl)
        nomEtPrenom.text = self.post.utilisateur.prenom + "  " + self.post.utilisateur.nom
        imageDuPost.telecharger(self.post.imageUrl)
        texteDuPost.text = self.post.texte
        if self.post.imageUrl == nil {
            imageDuPost.isHidden = true
        } else {
            imageDuPost.isHidden = false
        }
        
        let date = Date(timeIntervalSince1970: self.post.date)
        let formatteur = DateFormatter()
        let calendrier = Calendar.current
        if calendrier.isDateInToday(date) {
            formatteur.dateStyle = .none
            formatteur.timeStyle = .short
        } else {
            formatteur.dateStyle = .short
            formatteur.timeStyle = .none
        }
        let dateString = formatteur.string(from: date)
        dateLabel.text = dateString
        
        if let id = Auth.auth().currentUser?.uid {
            if self.post.likes.contains(id) {
                boutonLike.setImage(#imageLiteral(resourceName: "like_plein"), for: .normal)
            } else {
                boutonLike.setImage(#imageLiteral(resourceName: "like_vide"), for: .normal)
            }
        } else {
            boutonLike.setImage(#imageLiteral(resourceName: "like_vide"), for: .normal)
        }
        observerLikes()
    }
    
    func observerLikes() {
        
        let ref = Refs.obtenir.basePost.child(self.post.id)
        ref.observe(.childAdded) { (snap) in
            //Ajouté
            if let array = snap.value as? NSArray, let arrayString = array as? [String] {
                self.post.maj(likes: arrayString)
                self.miseEnPlace(post: self.post)
            }
        }
        ref.observe(.childRemoved) { (snap) in
            //Enlevé
            if let array = snap.value as? NSArray, let arrayString = array as? [String] {
                var mesLikes = self.post.likes
                for string in arrayString {
                    if let index = mesLikes.index(of: string) {
                        mesLikes.remove(at: index)
                    }
                }
                self.post.maj(likes: mesLikes)
                self.miseEnPlace(post: self.post)
            }
        }
        ref.observe(.childChanged) { (snap) in
            //Changé
            if let array = snap.value as? NSArray, let arrayString = array as? [String] {
                self.post.maj(likes: arrayString)
                self.miseEnPlace(post: self.post)
            }
        }
    }
    
    @IBAction func likeAppuye(_ sender: Any) {
        
        guard let id = Auth.auth().currentUser?.uid else { return }
        var array = self.post.likes
        if !array.contains(id) {
            array.append(id)
        } else {
            if let index = array.index(of: id) {
                array.remove(at: index)
            }
        }
        Refs.obtenir.basePost.child(self.post.id).updateChildValues([LIKES: array])
    }

}
