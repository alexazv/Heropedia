//
//  HeroAPISource.swift
//  Heropedia
//
//  Created by Alexandre Azevedo on 12/13/20.
//

import Foundation
import Alamofire
import ObjectMapper

class HeroAPISource: HeroDataSource {
    
    private let requestMaker: RequestMaker
    private let apiKey = "3acf0a6200e17381321fef7e2237d020"
    private let baseUrl = "https://gateway.marvel.com:443/v1/public/"
    private let hash = "aa54262b2709eba1e295dcf8e6ef75ae"
    private let stamp = "heropedia"
    private let limit = 20
    
    init(requestMaker: RequestMaker? = nil) {
        guard let requestMaker = requestMaker else {
            self.requestMaker = HTTPRequestMaker()
            return
        }
        self.requestMaker = requestMaker
    }
    
    private var parameters: Parameters {
        return [
            "apikey": self.apiKey,
            "ts": self.stamp,
            "hash": self.hash,
            "limit": self.limit
        ]
    }
    
    private func decode<T: Mappable>(_ type: T.Type, from data: Data) throws -> T? {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            let item = Mapper<T>().map(JSONObject: json)
            return item
    }
    
    func getItems(page: Int, completion: @escaping ([Hero]?, Error?, Bool) -> Void) {
        
        let url = "\(self.baseUrl)characters"
        let offset = limit*page
        
        var parameters = self.parameters
        parameters["offset"] = offset
        
        requestMaker.request(url, parameters: parameters) { data, error in
            
            guard let data = data, error == nil else {
                completion(nil, error, false)
                return
            }
            
            do {
                let heroResponse: APIResponse<Hero>? = try self.decode(APIResponse<Hero>.self, from: data)
                completion(heroResponse?.results, nil, heroResponse?.total ?? 0 > offset )
            } catch let error {
                completion(nil, error, false)
            }
        }
    }
    
    func getDetail(heroId: Int, completion: @escaping (HeroDetail?, Error?) -> Void) {
        let url = "\(self.baseUrl)characters/\(heroId)"
        
        requestMaker.request(url, parameters: parameters) { data, error in
            
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let heroResponse: APIResponse<HeroDetail>? = try self.decode(APIResponse<HeroDetail>.self, from: data)
                completion(heroResponse?.results?.first, nil)
            } catch let error {
                completion(nil, error)
            }
        }
    }
}
