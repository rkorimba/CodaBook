//
//  ImageRonde.swift
//  CodaBook
//
//  Created by Riad Korimbacus on 02/06/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit

class ImageRonde: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        miseEnPlace()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        miseEnPlace()
    }
    
    func miseEnPlace() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        contentMode = .scaleAspectFill
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2   
    }
    
}
