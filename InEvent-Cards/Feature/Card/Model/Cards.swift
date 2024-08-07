//
//  Cards.swift
//  InEvent-Cards
//
//  Created by Henrique Marques on 06/08/24.
//

import Foundation

// MARK: - ResultModel

struct ResultModel: Codable {
    let success: Bool
    let deckID: String
    let cards: [Card]
    var remaining: Int

    enum CodingKeys: String, CodingKey {
        case success
        case deckID = "deck_id"
        case cards, remaining
    }
}

// MARK: - Card

struct Card: Codable {
    let code: String
    let image: String
    let value, suit: String
}

struct ResponseSuccess: Codable {
    let success: Bool
    let deckID: String
    let remaining: Int

    enum CodingKeys: String, CodingKey {
        case success
        case deckID = "deck_id"
        case remaining
    }
}
