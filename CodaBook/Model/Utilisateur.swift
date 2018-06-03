//
//  Utilisateur.swift
//  CodaBook
//
//  Created by Riad Korimbacus on 01/06/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit

class Utilisateur {
    
    private var _id: String
    private var _prenom: String
    private var _nom: String
    private var _imageUrl: String?
    
    var id: String {
        return _id
    }
    
    var prenom: String {
        return _prenom
    }
    
    var nom: String {
        return _nom
    }
    
    var imageUrl: String? {
        return _imageUrl
    }
    
    init(id: String, prenom:String, nom: String, imageUrl: String?) {
        self._id = id
        self._prenom = prenom
        self._nom = nom
        self._imageUrl = imageUrl
    }
    
    
}
