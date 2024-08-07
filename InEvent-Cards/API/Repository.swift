//
//  Repository.swift
//  InEvent-Cards
//
//  Created by Henrique Marques on 06/08/24.
//

import Foundation
import Alamofire

class Repository {
    
    static let manager: Alamofire.Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 0
        config.timeoutIntervalForResource = 0
        return Alamofire.Session(configuration: config)
    }()
    
}
