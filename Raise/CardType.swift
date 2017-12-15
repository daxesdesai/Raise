//
//  CardType.swift
//  Raise
//
//  Created by dkdesai on 12/15/17.
//  Copyright © 2017 Daxes Desai. All rights reserved.
//

import Foundation

public func ==(lhs: CardType, rhs: CardType) -> Bool {
    return lhs.name == rhs.name
}

public struct CardType: Equatable {
    
    public var name: String
    
    public var regex: String
    
    public init(dict: [String: Any]) {
        if let name = dict["name"] as? String {
            self.name = name
        } else {
            self.name = ""
        }
        
        if let regex = dict["regex"] as? String {
            self.regex = regex
        } else {
            self.regex = ""
        }
    }
    
}
