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
    
    private let apiKey = "3acf0a6200e17381321fef7e2237d020"
    private let baseUrl = "https://gateway.marvel.com:443/v1/public/"
    private let hash = "aa54262b2709eba1e295dcf8e6ef75ae"
    private let stamp = "heropedia"
    
    private var parameters: Parameters {
        return [
            "apikey": self.apiKey,
            "ts": self.stamp,
            "hash": self.hash,
        ]
    }
    
    func getItems(completion: @escaping ([Hero]?, Error?) -> Void) {
        
        let url = "\(self.baseUrl)characters"
        
        AF.request(url, method: .get, parameters: self.parameters)
            .validate(statusCode: 200..<300)
            .response { response in
            
                guard response.error == nil else {
                    completion(nil, response.error)
                    return
                }
                
                guard let data = response.data else {
                    completion(nil, RuntimeError("error"))
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    let heroResponse = Mapper<APIResponse<Hero>>().map(JSONObject: json)
                    completion(heroResponse?.results, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
    }
    
    func getDetail(heroId: Int, completion: @escaping (HeroDetail?, Error?) -> Void) {
        let url = "\(self.baseUrl)characters/\(heroId)"
        
        AF.request(url, method: .get, parameters: self.parameters)
            .validate(statusCode: 200..<300)
            .response { response in
            
                guard response.error == nil else {
                    completion(nil, response.error)
                    return
                }
                
                guard let data = response.data else {
                    completion(nil, RuntimeError("error"))
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    let heroResponse = Mapper<APIResponse<HeroDetail>>().map(JSONObject: json)
                    completion(heroResponse?.results?.first, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
    }
}
