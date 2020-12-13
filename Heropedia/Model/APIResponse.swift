//
//  APIResponse.swift
//  Heropedia
//
//  Created by Alexandre Azevedo on 13/12/20.
//

import Foundation
import ObjectMapper

class APIResponse<T: Mappable>: Mappable {
    var results: [T]?
    
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        results <- map["data.results"]
    }
}
