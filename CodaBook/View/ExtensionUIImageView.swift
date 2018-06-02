//
//  ExtensionUIImageView.swift
//  CodaBook
//
//  Created by Riad Korimbacus on 02/06/2018.
//  Copyright © 2018 Riad Korimbacus. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func telecharger(_ urlString: String?) {
        
        image = #imageLiteral(resourceName: "Superman-facebook.svg")
        guard urlString != nil, let url = URL(string: urlString!) else { return }
        sd_setImage(with: url, completed: nil)
    }
    
    
}
