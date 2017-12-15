//
//  Token.swift
//  Raise
//
//  Created by dkdesai on 12/14/17.
//  Copyright © 2017 Daxes Desai. All rights reserved.
//

import Foundation

struct Token {
    
    let id: Int
    let tokenDonorName: String
    let tokenCCNumber: Int
    let tokenExpMonth: Int
    let tokenExpYear: Int
    let tokenCVC: Int
    let tokenDate: NSDate
    
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? 0
        tokenDonorName = json["tokenDonorName"] as? String ?? ""
        tokenCCNumber = json["tokenCCNumber"] as? Int ?? 0
        tokenExpMonth = json["tokenExpMonth"] as? Int ?? 0
        tokenExpYear = json["tokenExpYear"] as? Int ?? 0
        tokenCVC = json["tokenCVC"] as? Int ?? 0
        tokenDate = json["tokenDate"] as? NSDate ?? NSDate.distantPast as NSDate
    }
}
