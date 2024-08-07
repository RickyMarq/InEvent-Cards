//
//  ConfigureController.swift
//  InEvent-Cards
//
//  Created by Henrique Marques on 06/08/24.
//

import Foundation

public protocol Controller {
    func configureDelegates()
    func configureAdditionalBehaviors()
}

extension Controller {
    func initController() {
        configureDelegates()
        configureAdditionalBehaviors()
    }
}
