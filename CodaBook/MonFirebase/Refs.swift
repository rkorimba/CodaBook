//
//  Refs.swift
//  CodaBook
//
//  Created by Riad Korimbacus on 01/06/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class Refs {
    
    static let obtenir = Refs()
    
    let baseBDD = Database.database().reference()
    let baseStockage = Storage.storage().reference()
    
    var baseUtilisateur: DatabaseReference {
        return baseBDD.child(UTILISATEUR)
    }
    
    var basePhotosDeProfil: StorageReference {
        return baseStockage.child(UTILISATEUR)
    }
    
    
}
