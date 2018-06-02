//
//  VueCodaBook.swift
//  CodaBook
//
//  Created by Riad Korimbacus on 02/06/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit

class VueCodaBook: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        miseEnPlace()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        miseEnPlace()
    }

    func miseEnPlace() {
        
        backgroundColor = .white
        layer.mep(18)
    }

}
