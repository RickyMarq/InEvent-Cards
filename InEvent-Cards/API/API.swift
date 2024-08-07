//
//  API.swift
//  InEvent-Cards
//
//  Created by Henrique Marques on 06/08/24.
//

import Foundation
import Alamofire

enum API: URLRequestConvertible {
    
    case deckOfCards
    case getOneMoreCard(deckId: String)
    case shuffleCards(deckId: String)
    

    func asURLRequest() throws -> URLRequest {
        var _url: URL?
        let baseUrl = "https://deckofcardsapi.com/api/".appending(path)
        
        switch self {
        default:
            _url = URL(string: baseUrl)
        }
        
        guard let url = _url else {
            throw AFError.sessionInvalidated(error: nil)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
    
}

// MARK: HTTP Method

extension API {
    
    private var method: HTTPMethod {
        switch self {
        case .deckOfCards, .shuffleCards, .getOneMoreCard
            : return .get
        }
    }
}

extension API {
    
    private var path: String {
        switch self {
            
        case .deckOfCards:
            
            return APIPath.deck + APIPath.new + APIPath.draw + "?count=1"
        
        case .shuffleCards(let deckId):
            
            return APIPath.deck + deckId + "/" + APIPath.shuffle + "?count=1"
        
        case .getOneMoreCard(deckId: let deckId):
            
            return APIPath.deck + deckId + "/" + APIPath.draw + "?count=1"
        }
    }
}
