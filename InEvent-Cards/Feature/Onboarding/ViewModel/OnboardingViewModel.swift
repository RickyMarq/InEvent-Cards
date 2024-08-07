//
//  OnboardingViewModel.swift
//  InEvent-Cards
//
//  Created by Henrique Marques on 06/08/24.
//

import Foundation

class OnboardingViewModel {
    
    let getOnboardingInfo: [OnboardingModel] = [
        OnboardingModel(name: "Olá, bem vindo(a) ao InEvent Cards",
                        image: "pokerCards",
                        description: "Obrigado por analisar o meu teste."),
        
        OnboardingModel(name: "Vamos?",
                        image: "wavingPerson",
                        description: "Pressione o botão iniciar.")
    ]
    
    var count: Int {
        return getOnboardingInfo.count
    }
    
    func indexPath(indexPath: IndexPath) -> OnboardingModel {
        getOnboardingInfo[indexPath.row]
    }
    
}
