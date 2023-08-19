//
//  ResponseData.swift
//  FromTo
//
//  Created by 민지은 on 2023/08/20.
//  Copyright © 2023 alom.com. All rights reserved.
//

import Foundation

struct ResponseData: Codable {
    
    enum DayOfWeek: String, Codable {
        case MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY
    }
    
    struct StoreInfo: Codable {
        let success: Bool
        let result: [Result]
        let error: BaseException? = BaseException()
    }
    
    struct Result: Codable {
        let lat, lng: Double
        let fromToList: [FromToList]
    }
    
    struct FromToList: Codable {
        let dayOfWeek: DayOfWeek
        let openTime, closeTime: Int
    }
    
    struct BaseException: Codable, Error {
        var code: String? = nil
        var message: String? = nil
    }
    
}
