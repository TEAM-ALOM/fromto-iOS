//
//  FromTo_Network.swift
//  FromTo
//
//  Created by 민지은 on 2023/08/12.
//  Copyright © 2023 alom.com. All rights reserved.
//

import UIKit
import Alamofire

struct NetworkManager {
    static let shared = NetworkManager()
    
    func postInfo(storeId: String, lat: Int, lng: Int, dayOfWeek: Int, openTime: Int, closeTime: Int) {
        
        let url = "http://15.164.233.168:8080/api/v1/storeInfo"
        
        let parameters: [String: Any] = [
            "storeId": storeId,
            "lat": lat,
            "lng": lng,
            "fromToList": [
                [
                    "dayOfWeek": dayOfWeek,
                    "openTime": openTime,
                    "closeTime": closeTime
                ]
            ]
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("Request succeeded with response: \(value)")
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
    }
    
    func getInfo(top: Double, btm: Double, lft: Double, rgt: Double, completion: @escaping (Result<[ResponseData.Result], Error>, Bool?) -> Void) {
        let url = "http://15.164.233.168:8080/api/v1/storeInfo/list?top=\(top)&btm=\(btm)&lft=\(lft)&rgt=\(rgt)"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json"])
        .responseDecodable(of: ResponseData.StoreInfo.self) { response in
            switch response.result {
            case .success(let storeInfo):
                let results = storeInfo.result
                let success = storeInfo.success
                DispatchQueue.main.async {
                    completion(.success(results), success)
                }
                print("Success: \(success)")
                print("Results: \(results)")
                if let error = storeInfo.error {
                    print("Error: Code: \(error.code ?? "null"), Message: \(error.message ?? "null")")
                } else {
                    print("Error: null")
                }
            case .failure(let error):
                if let statusCode = response.response?.statusCode, statusCode == 404 {
                    print("Error: 404")
                }
                if let storeInfo = try? response.result.get() {
                    completion(.failure(storeInfo.error!), nil)
                    print("Error: Code: \(storeInfo.error?.code ?? "null"), Message: \(storeInfo.error?.message ?? "null")")
                } else {
                    completion(.failure(error), nil)
                    print("Error: \(error)")
                }
            }
        }
    }
    
}
