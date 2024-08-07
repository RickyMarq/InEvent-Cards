//
//  CardService.swift
//  InEvent-Cards
//
//  Created by Henrique Marques on 06/08/24.
//

import Foundation
import ServiceKit

protocol CardServiceMethods: AnyObject {
    func shuffleCards(deckId: String, completion: @escaping (ResponseSuccess?, ServiceKit.NetworkError?) -> Void)
    func getDeck(completion: @escaping (ResultModel?, NetworkError?) -> Void)
    func getOneMoreCard(deckId: String, completion: @escaping (ResultModel?, NetworkError?) -> Void)
}

class CardService: CardServiceMethods {
    
    func shuffleCards(deckId: String, completion: @escaping (ResponseSuccess?, ServiceKit.NetworkError?) -> Void) {
        Repository.manager.request(API.shuffleCards(deckId: deckId)).responseDecodable(of: ResponseSuccess.self) { response in
            guard let data = response.data else { completion(nil, nil) ; return }
            NetworkLogger.log(request: response.request, response: response.response, data: data, error: response.error)
            
            switch response.result {
            case .success(let success):
                completion(success, nil)

            case .failure(let error):
                completion(nil, NetworkError.decodingError(error))
    
            }
        }
    }
    
    
    func getDeck(completion: @escaping (ResultModel?, ServiceKit.NetworkError?) -> Void) {
        
        Repository.manager.request(API.deckOfCards).responseDecodable(of: ResultModel.self) { response in
            guard let data = response.data else { completion(nil, nil) ; return }
            NetworkLogger.log(request: response.request, response: response.response, data: data, error: response.error)
            
            switch response.result {
            case .success(let success):
                completion(success, nil)

            case .failure(let error):
                completion(nil, NetworkError.decodingError(error))
    
            }
        }
    }
    
    func getOneMoreCard(deckId: String, completion: @escaping (ResultModel?, ServiceKit.NetworkError?) -> Void) {
        Repository.manager.request(API.getOneMoreCard(deckId: deckId)).responseDecodable(of: ResultModel.self) { response in
            guard let data = response.data else { completion(nil, nil) ; return }
            NetworkLogger.log(request: response.request, response: response.response, data: data, error: response.error)
            
            switch response.result {
            case .success(let success):
                completion(success, nil)

            case .failure(let error):
                completion(nil, NetworkError.decodingError(error))
    
            }
        }
    }
}
