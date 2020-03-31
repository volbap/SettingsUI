//
//  SwitchCell.swift
//  SettingsUI
//
//  Created by Pablo Villar on Mar 22, 2020.
//  Copyright © 2020 volbap. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {

	// MARK: - Public
    
    var onChange: ((Bool) -> Void)?
    
    func configure(title: String, value: Bool) {
        titleLabel.text = title
        switcher.isOn = value
    }
    
    // MARK: - Outlets

	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var switcher: UISwitch!
    
    // MARK: - Actions
    
    @IBAction private func switchValue(_ sender: UISwitch) {
        onChange?(sender.isOn)
    }

}
