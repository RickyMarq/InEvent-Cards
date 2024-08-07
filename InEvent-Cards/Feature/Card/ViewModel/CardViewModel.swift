//
//  CardViewModel.swift
//  InEvent-Cards
//
//  Created by Henrique Marques on 06/08/24.
//

import Foundation

protocol CardViewModelProtocol: AnyObject {
    func fetchSuccess()
    func fetchFailure(message: String)
    func fetchCardsSuccess()
}

class CardViewModel: NSObject {
    private weak var delegate: CardViewModelProtocol?
    private var cardService: CardService = CardService()
    private var cardModel: ResultModel?
    private var deckId: String = ""
    private var previousCards: [String] = []
}

extension CardViewModel {
    
    func delegate(delegate: CardViewModelProtocol) {
        self.delegate = delegate
    }
    
}

extension CardViewModel {
    
    func getCards() {
        cardService.getDeck { [weak self] response, error in
            guard let self else { return }
            
            if let response {
                cardModel = response
                deckId = response.deckID
                delegate?.fetchSuccess()
            } else {
                delegate?.fetchFailure(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func getOneMoreCard() {
        cardService.getOneMoreCard(deckId: deckId) { [weak self] response, error in
            guard let self else { return }
            
            if let response {
                cardModel = response
                deckId = response.deckID
                self.cardModel = response
                
                if let previousCard = self.cardModel?.cards.first?.image {
                    self.previousCards.append(previousCard)
                }
                
                if response.remaining == 0 {
                    shuffleCards()
                    delegate?.fetchSuccess()
                }
                
                delegate?.fetchSuccess()
            } else {
                delegate?.fetchFailure(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func shuffleCards() {
        cardService.shuffleCards(deckId: deckId) { [weak self] response, error in
            guard let self else { return }
            
            if let response {
                deckId = response.deckID
                cardModel?.remaining = response.remaining
                delegate?.fetchCardsSuccess()
            } else {
                delegate?.fetchFailure(message: error?.localizedDescription ?? "")
            }
        }
    }
}

extension CardViewModel {
    
    func getCardImage() -> String {
        return cardModel?.cards[0].image ?? ""
    }
    
    func remainingCards() -> Int {
        return cardModel?.remaining ?? 0
    }
}

extension CardViewModel {
    
    func updatePreviousCards(with newCard: String) {
        if previousCards.count == 5 {
            previousCards.removeFirst()
        }
        previousCards.append(newCard)
    }
    
    func getPreviousCards() -> [String] {
        return previousCards
    }
}
