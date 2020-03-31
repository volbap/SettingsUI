//
//  Item.swift
//  SettingsUI
//
//  Created by Pablo Villar on Mar 23, 2020.
//  Copyright © 2020 volbap. All rights reserved.
//

import Foundation

class Item {
    var name: String
    var value: Value

    enum Value {
        case bool(Bool)
        case number(NSNumber)
        case string(String)
        case items([Item])
        case unknown
    }
    
    init(name: String, value: Value) {
        self.name = name
        self.value = value
    }
    
}

extension Item: CustomDebugStringConvertible {
    
    var debugDescription: String {
        let val: String
        switch value {
        case .bool(let bool): val = "Bool(\(bool))"
        case .number(let number): val = "Number(\(number))"
        case .string(let string): val = "String(\(string))"
        case .items(let items): val = "Items(\n\(items)\n)"
        case .unknown: val = "Unknown()"
        }
        return "Item(name: '\(name)', value: \(val))"
    }
    
}
