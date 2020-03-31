//
//  Configuration.swift
//  SettingsUI
//
//  Created by Pablo Villar on Mar 22, 2020.
//  Copyright © 2020 volbap. All rights reserved.
//

import Foundation

public struct Configuration {
    
    public static var shared = Configuration()
    
    public let encoder: JSONEncoder
    public let decoder: JSONDecoder
    public let formatter: NumberFormatter
    
    public init(encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder(), formatter: NumberFormatter = NumberFormatter()) {
        self.encoder = encoder
        self.decoder = decoder
        self.formatter = formatter
    }
    
}
