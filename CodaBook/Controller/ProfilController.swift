//
//  ProfilController.swift
//  CodaBook
//
//  Created by Riad Korimbacus on 01/06/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProfilController: UIViewController {

    @IBOutlet weak var photoDeProfil: UIImageView!
    @IBOutlet weak var prenomLabel: UILabel!
    @IBOutlet weak var nomLabel: UILabel!
    
    var profil: Utilisateur?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obtenirProfil()
    }
    
    func obtenirProfil() {
        
        guard let id = Auth.auth().currentUser?.uid else { return }
        let ref = Refs.obtenir.baseUtilisateur.child(id)
        ref.observe(.value) { (snapshot) in
            print(snapshot)
            if let dict = snapshot.value as? [String:String], let prenom = dict[PRENOM], let nom = dict[NOM] {
                let nouvelUtilisateur = Utilisateur(prenom: prenom, nom: nom, imageUrl: dict[IMAGE_URL])
                self.profil = nouvelUtilisateur
                self.miseAJourDonnees()
            }
        }
    }

    func miseAJourDonnees() {
        
        guard profil != nil else { return }
        prenomLabel.text = "Prénom: " + self.profil!.prenom
        nomLabel.text = "Nom: " + self.profil!.nom
    }
    
    @IBAction func modifierProfilAction(_ sender: Any) {
    }
    
    @IBAction func decoAction(_ sender: Any) {
        
        Alerte.montrer.deco(controller: self)
    }
    
}
