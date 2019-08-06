//
//  UIBorderedView.swift
//  CryptoCoinSearch
//
//  Created by Panfilo Mariano Jr on 06/08/2019.
//  Copyright © 2019 Panfilo Mariano Jr. All rights reserved.
//

import Foundation
import UIKit

open class BorderedView: UIView {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // custom setup
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // custom setup
    }
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.cornerRadius)
        }set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
}

