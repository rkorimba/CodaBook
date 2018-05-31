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
        if  Auth.auth().currentUser?.uid != nil {
            //Vérifier si utilisateur dans BDD
            //Passer à l'app
            
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
    
    @IBAction func seConnecterAction(_ sender: Any) {
        
        self.view.endEditing(true)
        if let adresse = mailTF.text, adresse != "" {
            if let mdp = mdpTF.text, mdp != "" {
                
            } else {
                Alerte.montrer.erreur(message: MDP_VIDE, controller: self)
            }
        } else {
            Alerte.montrer.erreur(message: ADRESSE_VIDE, controller: self)
        }
    }
    
}
