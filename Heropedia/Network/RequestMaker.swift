//
//  RequestMaker.swift
//  Heropedia
//
//  Created by Alexandre Azevedo on 14/12/20.
//

import Foundation
import ObjectMapper

protocol RequestMaker {
    func request(_ url: String, parameters: [String:Any], completion: @escaping (Data?, Error?) -> Void)
}
