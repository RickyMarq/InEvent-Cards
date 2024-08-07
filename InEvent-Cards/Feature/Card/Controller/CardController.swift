//
//  CardController.swift
//  InEvent-Cards
//
//  Created by Henrique Marques on 06/08/24.
//

import Foundation
import UIKit
import Kingfisher

class CardController: UIViewController {
    
    private var cardView: CardView = CardView()
    private var cardViewModel: CardViewModel = CardViewModel()
    private var alert: Alerts?
    
    override func loadView() {
        view = cardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = Alerts(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initController()
        cardViewModel.getCards()
    }
    
    @objc func shuffleAction() {
        cardViewModel.shuffleCards()
    }
    
}

extension CardController: Controller {
    
    func configureDelegates() {
        cardViewModel.delegate(delegate: self)
        cardView.delegate(delegate: self)
    }
    
    func configureAdditionalBehaviors() {
        title = "Cartas"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        overrideUserInterfaceStyle = .light
        let shuffleButton = UIBarButtonItem(title: "Shuffle", style: .done, target: self, action: #selector(shuffleAction))
        navigationItem.rightBarButtonItem = shuffleButton
    }
    
}

extension CardController: CardViewModelProtocol {
    
    func fetchCardsSuccess() {
        alert?.getAlert(title: "Embaralhado", message: "As cartas foram embaralhadas com sucesso", buttonMessage: "Cancel")
        cardView.updateRemainingCardsLabel(with: cardViewModel.remainingCards())
    }
    
    
    func fetchSuccess() {
        let url = cardViewModel.getCardImage()
        let previousCards = cardViewModel.getPreviousCards()
        
        cardView.updateCardButtonImage(with: url)
        
        UIView.transition(with: cardView.cardButton, duration: 0.3, options: .transitionFlipFromTop, animations: {
            self.cardView.cardImage.kf.setImage(with: URL(string: url))
        }, completion: nil)
        
        cardView.updateRemainingCardsLabel(with: cardViewModel.remainingCards())
        cardView.updatePreviousCards(with: previousCards)
    }
    
    func fetchFailure(message: String) {
        alert?.getAlert(title: "Erro", message: "Erro ao tentar obter as cartas, desculpe :/", buttonMessage: "Cancel")
    }
    
}

extension CardController: CardViewProtocol {
    
    func cardButtonAction() {
        cardViewModel.getOneMoreCard()
    }
    
}
