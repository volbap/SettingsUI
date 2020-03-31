//
//  Settings.swift
//  ClientExample
//
//  Created by Pablo Villar on Mar 23, 2020.
//  Copyright © 2020 volbap. All rights reserved.
//

import Foundation

struct Settings: Codable {
    let flag1: Bool
    let flag2: Bool
    let baseURL: String
    let min: Int
    let max: Int
    let other: Other
    struct Other: Codable {
        let flag3: Bool
        let text: String
        let another: Another
        struct Another: Codable {
            let multiplier: Float
        }
    }
}
