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

    @IBOutlet weak var photoDeProfil: ImageRonde!
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
        photoDeProfil.telecharger(self.profil!.imageUrl)
    }
    
    @IBAction func modifierProfilAction(_ sender: Any) {
        
        if let bouton = sender as? UIButton {
            var array = [String]()
            switch bouton.tag {
            case 0: array.append(PRENOM)
            case 1: array.append(NOM)
            default: break
            }
            guard array.count == 1 else { return }
            Alerte.montrer.alerteTF(titre: MODIFIER, message: array[0], array: array, controller: self, completion: nil)
        }
    }
    
    @IBAction func decoAction(_ sender: Any) {
        
        Alerte.montrer.deco(controller: self)
    }
    
}
