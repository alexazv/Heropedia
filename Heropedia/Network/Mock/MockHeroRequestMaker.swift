//
//  MockRequestMaker.swift
//  Heropedia
//
//  Created by Alexandre Azevedo on 14/12/20.
//

import Foundation

class MockHeroRequestMaker: RequestMaker {
    
    private var returnError: Bool
    
    init(returnError: Bool = false) {
        self.returnError = returnError
    }
    
    func request(_ url: String, parameters: [String : Any], completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.main.async {
            
            guard !self.returnError else {
                completion(nil, RuntimeError(""))
                return
            }
            
            guard let path = Bundle.main.path(forResource: "MockHero", ofType: "json") else {
                completion(nil, nil)
                return
            }
            
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            
            completion(data, nil)
        }
    }
}
