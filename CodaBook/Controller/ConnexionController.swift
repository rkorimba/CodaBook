//
//  ConnexionController.swift
//  CodaBook
//
//  Created by Riad Korimbacus on 31/05/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit
import FirebaseAuth

class ConnexionController: UIViewController {

    @IBOutlet weak var titreLabel: UILabel!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var mdpTF: UITextField!
    @IBOutlet weak var connexionBouton: BoutonCodabook!
    @IBOutlet weak var pasDeCompteLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(cacherClavier)))
      
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cacher(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let id = Auth.auth().currentUser?.uid {
            verifierUtilisateur(id: id)
        } else {
            cacher(false)
        }
    }
    
    func cacher(_ bool: Bool) {
        
        titreLabel.isHidden = bool
        mailTF.isHidden = bool
        mdpTF.isHidden = bool
        connexionBouton.isHidden = bool
        pasDeCompteLabel.isHidden = bool
    }
    
    @objc func cacherClavier() {
        
        view.endEditing(true)
    }
    
    func completion(_ user: AuthDataResult?, _ error: Error?) {
        
        if let erreur = error {
            let nsErreur = erreur as NSError
            if nsErreur.code == 17011 {
                //Creer utilisateur
                Auth.auth().createUser(withEmail: mailTF.text!, password: mdpTF.text!, completion: completion(_:_:))
            } else {
                Alerte.montrer.erreur(message: nsErreur.convertirErreurFirebaseEnString(), controller: self)
            }
        }
        if let utilisateur = user {
            verifierUtilisateur(id: utilisateur.user.uid)
        }
        
    }
    
    func verifierUtilisateur(id: String) {
        
        let referenceFirebase = Refs.obtenir.baseUtilisateur.child((id))
        referenceFirebase.observe(.value) { (snapshot) in
            if snapshot.exists() {
                //Passer a l'app
                self.performSegue(withIdentifier: SEGUE_ID, sender: nil)
            } else {
                self.finalisation()
            }
        }
    }
    
    func finalisation() {
        
        Alerte.montrer.alerteTF(titre: FINALISER, message: DERNIER_PAS, array: [PRENOM, NOM], controller: self, completion: { (success) -> (Void) in
            if let bool = success, bool == true {
                // Passer a l'app
                
            } else {
                self.finalisation()
            }
        })
    }
    
    @IBAction func seConnecterAction(_ sender: Any) {
        
        self.view.endEditing(true)
        if let adresse = mailTF.text, adresse != "" {
            if let mdp = mdpTF.text, mdp != "" {
                Auth.auth().signIn(withEmail: adresse, password: mdp, completion: completion(_: _:))
            } else {
                Alerte.montrer.erreur(message: MDP_VIDE, controller: self)
            }
        } else {
            Alerte.montrer.erreur(message: ADRESSE_VIDE, controller: self)
        }
    }
    
}
