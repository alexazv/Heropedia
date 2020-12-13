//
//  Hero.swift
//  Heropedia
//
//  Created by Alexandre Azevedo on 13/12/20.
//

import Foundation
import ObjectMapper

class Hero: Mappable {
    var heroId: Int?
    var name: String?
    var imageUrl: URL?
    
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        heroId <- map["id"]
        name <- map["name"]
        
        var path: String = ""
        path <- map["thumbnail.path"]
        
        var type: String = ""
        type <- map["thumbnail.extension"]
        
        imageUrl = URL(string: "\(path).\(type)")
    }
}
