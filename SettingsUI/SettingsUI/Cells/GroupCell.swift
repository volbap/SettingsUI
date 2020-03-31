//
//  GroupCell.swift
//  SettingsUI
//
//  Created by Pablo Villar on Mar 29, 2020.
//  Copyright © 2020 volbap. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

	// MARK: - Public
    
	func configure(title: String) {
        titleLabel.text = title
	}

	// MARK: - Outlets

	@IBOutlet weak var titleLabel: UILabel!
    
}
