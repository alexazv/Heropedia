//
//  HeroDataSource.swift
//  Heropedia
//
//  Created by Alexandre Azevedo on 12/13/20.
//

import Foundation

protocol HeroDataSource {
    func getItems(page: Int, completion: @escaping ([Hero]?, Error?, Bool) -> Void )
    func getDetail(heroId: Int, completion: @escaping (HeroDetail?, Error?) -> Void )
}
