//
//  DataSource.swift
//  Heropedia
//
//  Created by Alexandre Azevedo on 15/12/20.
//

import Foundation

class DataSource {
    static private var mock = false;
    static private var returnError = false;
    
    static func heroDataSource() -> HeroDataSource {
        if (mock) {
            return HeroAPISource(requestMaker: MockHeroRequestMaker(returnError: returnError))
        } else {
            return HeroAPISource()
        }
    }
}
