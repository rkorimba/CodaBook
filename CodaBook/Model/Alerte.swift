//
//  Alerte.swift
//  CodaBook
//
//  Created by Riad Korimbacus on 31/05/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit
import FirebaseAuth

typealias Success = (_ bool: Bool?) -> (Void)

class Alerte {
    
    static let montrer = Alerte()
    
    func erreur(message: String, controller: UIViewController) {
        
        let alerte = UIAlertController(title: ERREUR, message: message, preferredStyle: .alert)
        alerte.addAction(UIAlertAction(title: OK, style: .default, handler: nil))
        controller.present(alerte, animated: true, completion: nil)
    }
 
    func alerteTF(titre: String, message: String, array: [String], controller: UIViewController, completion: Success?) {
        
        guard let id = Auth.auth().currentUser?.uid else { return }
        let alerte = UIAlertController(title: titre, message: message, preferredStyle: .alert)
        for a in array {
            alerte.addTextField(configurationHandler: {(textfield) in
                textfield.placeholder = a
            })
        }
        let ok = UIAlertAction(title: OK, style: .default) { (action) in
            var dict: [String: String] = [:]
            for x in (0...array.count) {
                if let tfs = alerte.textFields, tfs.count > x {
                    let textField = tfs[x] as UITextField
                    if let string = textField.text, string != "" {
                        dict[array[x]] = string
                    }
                }
            }
            if dict.count == array.count {
                let reference = Refs.obtenir.baseUtilisateur.child(id)
                reference.updateChildValues(dict)
                completion?(true)
            } else {
                completion?(false)
            }
        }
        alerte.addAction(ok)
        alerte.addAction(UIAlertAction(title: ANNULER, style: .cancel, handler: nil))
        controller.present(alerte, animated: true, completion: nil)
    }
}
