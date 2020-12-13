//
//  HeroDataSource.swift
//  Heropedia
//
//  Created by Alexandre Azevedo on 12/13/20.
//

import Foundation

protocol HeroDataSource {
    func getItems(completion: @escaping ([Hero]?, Error?) -> Void )
    func getDetail(heroId: Int, completion: @escaping (HeroDetail?, Error?) -> Void )
}
