//
//  NumericCell.swift
//  SettingsUI
//
//  Created by Pablo Villar on Mar 29, 2020.
//  Copyright © 2020 volbap. All rights reserved.
//

import UIKit

class NumericCell: UITableViewCell {

	// MARK: - Public
    
    var onChange: ((NSNumber) -> Void)?
    
    func configure(title: String, value: NSNumber) {
        titleLabel.text = title
        textField.text = formatter.string(from: value)
	}

	// MARK: - Outlets

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var textField: UITextField!
    
    @IBAction private func textChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        if let value = formatter.number(from: text) {
            hideErrorState()
            onChange?(value)
        } else {
            showErrorState()
        }
    }

	// MARK: - Private
    
    private let formatter = Configuration.shared.formatter
    
    private func showErrorState() {
        titleLabel.textColor = .red
    }
    
    private func hideErrorState() {
        titleLabel.textColor = .black
    }
    
}
