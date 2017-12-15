//
//  DonorInfo.swift
//  Raise
//
//  Created by dkdesai on 12/14/17.
//  Copyright © 2017 Daxes Desai. All rights reserved.
//

import Foundation

struct DonorInfo: Codable {
    
    let name: String
    let ccNumber: Int
    let expMonth: Int
    let expYear: Int
    let cvcCode: Int
    
}
