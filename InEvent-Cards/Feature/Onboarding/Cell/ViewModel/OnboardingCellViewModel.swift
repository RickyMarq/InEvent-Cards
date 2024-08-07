//
//  OnboardingCellViewModel.swift
//  InEvent-Cards
//
//  Created by Henrique Marques on 06/08/24.
//

import Foundation
import UIKit

class OnboardingCellViewModel {
    
    var onboardingModel: OnboardingModel?
    
    init(onboardingModel: OnboardingModel? = nil) {
        self.onboardingModel = onboardingModel
    }
    
    var primaryLabel: String {
        return onboardingModel?.name ?? ""
    }
    
    var secondaryLabel: String {
        return onboardingModel?.description ?? ""
    }
    
    var imageString: String {
        return onboardingModel?.image ?? ""
    }
}
