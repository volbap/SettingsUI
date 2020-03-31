//
//  TextCell.swift
//  SettingsUI
//
//  Created by Pablo Villar on Mar 23, 2020.
//  Copyright © 2020 volbap. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

    // MARK: - Public
    
    var onChange: ((String) -> Void)?
    
    func configure(title: String, value: String) {
        titleLabel.text = title
        textField.text = value
    }
    
    // MARK: - Outlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    // MARK: - Actions
    
    @IBAction private func textChanged(_ sender: UITextField) {
        onChange?(sender.text ?? "")
    }

}
