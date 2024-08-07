//
//  ViewCodeManager.swift
//  InEvent-Cards
//
//  Created by Henrique Marques on 06/08/24.
//

import Foundation
import UIKit

public protocol ViewCode: AnyObject {
    func initViewCode()
    func configureSubviews()
    func configureConstraints()
    func configureAdditionalBehaviors()
}

public extension ViewCode {
    func initViewCode() {
        configureSubviews()
        configureConstraints()
        configureAdditionalBehaviors()
    }
}
