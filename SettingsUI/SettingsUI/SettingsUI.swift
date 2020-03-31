//
//  SettingsNavigation.swift
//  SettingsUI
//
//  Created by Pablo Villar on Mar 23, 2020.
//  Copyright © 2020 volbap. All rights reserved.
//

import UIKit

public class SettingsUI {
    
    // TODO: Give option to make navigation as modal or as push
    
    public static func makeNavigation<T: Codable>(for settings: T, onSave: @escaping ((T) -> Void)) -> UINavigationController {
        let parser = ItemParser()
        let controller = SettingsViewController(settings: settings)
        controller.onSave = {
            if let updatedSettings: T = try? parser.makeObject(from: controller.items) {
                onSave(updatedSettings)
            } else {
                fatalError()
            }
        }        
        let navigation = UINavigationController(rootViewController: controller)
        return navigation
    }
    
}
