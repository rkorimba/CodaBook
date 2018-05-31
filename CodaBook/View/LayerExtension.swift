//
//  LayerExtension.swift
//  CodaBook
//
//  Created by Riad Korimbacus on 31/05/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit

extension CALayer {
    
    func mep(_ radius: CGFloat) {
        
        cornerRadius = radius
        shadowColor = UIColor.darkGray.cgColor
        shadowOffset = CGSize(width: 3.0, height: 3.0)
        shadowRadius = 3
    }
    
}
