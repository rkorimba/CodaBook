//
//  BoutonCodabook.swift
//  CodaBook
//
//  Created by Riad Korimbacus on 31/05/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit

class BoutonCodabook: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        miseEnPlace()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        miseEnPlace()
    }
    
    func miseEnPlace() {
        
        backgroundColor = UIColor.white
        tintColor = BLEU_CODABOOK
        layer.mep(10)
        
        
    }

}
