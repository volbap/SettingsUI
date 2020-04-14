//
//  ViewController.swift
//  ClientExample
//
//  Created by Pablo Villar on Mar 22, 2020.
//  Copyright © 2020 volbap. All rights reserved.
//

import UIKit
import SettingsUI

class ViewController: UIViewController {
    
    var settings = Settings(flag1: false, flag2: true, baseURL: "https://www.google.com/api/whatever/osd/asdddd/v1/hello_world.md", min: 0, max: 1, other: Settings.Other(flag3: true, text: "asd", another: Settings.Other.Another(multiplier: 1.815819)))
    
    @IBAction private func presentSettings(_ sender: UIButton) {
        let navigation = SettingsUI.makeNavigation(for: settings, onSave: save)
        present(navigation, animated: true)
    }
    
    private func save(_ settings: Settings) {
        dismiss(animated: true, completion: nil)
        print("Saving settings...")
        print(settings)
        self.settings = settings
    }
    
}

