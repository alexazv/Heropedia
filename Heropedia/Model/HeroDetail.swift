//
//  HeroDetail.swift
//  Heropedia
//
//  Created by Alexandre Azevedo on 13/12/20.
//

import Foundation
import ObjectMapper

class HeroDetail: Hero {
    var description: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        description <- map["description"]
    }
}
