//
//  ItemParser.swift
//  SettingsUI
//
//  Created by Pablo Villar on Mar 23, 2020.
//  Copyright © 2020 volbap. All rights reserved.
//

import Foundation

class ItemParser {
    
    let encoder = Configuration.shared.encoder
    let decoder = Configuration.shared.decoder

    func makeItem<T: Codable>(from object: T, name: String) -> Item? {
        if let data = try? encoder.encode(object),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let dict = json as? [String: Any] {
            return parseItem(name: name, object: dict)
        }
        return parseItem(name: name, object: object)
    }
    
    func makeObject<T: Codable>(from items: [Item]) throws -> T {
        let keyValues = try items.map(parseKeyValue)
        let dict = makeDictionary(from: keyValues)
        let data = try JSONSerialization.data(withJSONObject: dict, options: .fragmentsAllowed)
        return try decoder.decode(T.self, from: data)
    }
    
    private func parseItem(name k: String, object v: Any) -> Item? {
        if let number = v as? NSNumber {
            if number === kCFBooleanTrue {
                return Item(name: k, value: .bool(true))
            }
            if number === kCFBooleanFalse {
                return Item(name: k, value: .bool(false))
            }
            return Item(name: k, value: .number(number))
        }
        if let string = v as? String {
            return Item(name: k, value: .string(string))
        }
        if let dict = v as? [String: Any] {
            return Item(name: k, value: .items(dict.sortedByKey.compactMap(parseItem)))
        }
        return nil
    }
    
    private func parseKeyValue(from item: Item) throws -> (String, Any) {
        let value = try getValue(from: item)
        return (item.name, value)
    }
    
    private func getValue(from item: Item) throws -> Any {
        switch item.value {
        case .bool(let bool):
            return bool
        case .number(let number):
            return number
        case .string(let string):
            return string
        case .items(let items):
            return try toDictionary(items)
        case .unknown:
            throw Error.parsing
        }
    }
    
    private func makeDictionary(from keyValues: [(String, Any)]) -> [String: Any] {
        var dict: [String: Any] = [:]
        for (k, v) in keyValues {
            dict[k] = v
        }
        return dict
    }
    
    private func toDictionary(_ items: [Item]) throws -> [String: Any] {
        var dict: [String: Any] = [:]
        for item in items {
            let k = item.name
            let v = try getValue(from: item)
            dict[k] = v
        }
        return dict
    }
    
    enum Error: Swift.Error { case parsing }
        
}

private extension Dictionary where Key == String, Value == Any {
    
    var sortedByKey: [(String, Any)] {
        return sorted(by: { $0.0 < $1.0 })
    }
    
}
