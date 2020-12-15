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
    var seriesCount: Int = 0
    var storiesCount: Int = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        description <- map["description"]
        seriesCount <- map["series.available"]
        storiesCount <- map["stories.available"]
    }
}
