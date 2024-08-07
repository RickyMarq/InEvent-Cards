//
//  UIButton+Extension.swift
//  InEvent-Cards
//
//  Created by Henrique Marques on 06/08/24.
//

import Foundation
import UIKit

extension UIButton {
    
    enum ButtonStyleAppearance {
        case primary
    }
    
    func setButtonDesign(layout: ButtonStyleAppearance) {
        switch layout {
            
        case .primary:
            translatesAutoresizingMaskIntoConstraints = false
            tintColor = .white
            backgroundColor = .systemOrange
            layer.cornerRadius = 8
            layer.masksToBounds = false
            setTitleColor(.white, for: .normal)
        }
    }
}
