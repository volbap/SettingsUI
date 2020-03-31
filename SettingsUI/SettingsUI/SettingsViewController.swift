//
//  SettingsViewController.swift
//  SettingsUI
//
//  Created by Pablo Villar on Mar 22, 2020.
//  Copyright © 2020 volbap. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

	// MARK: - Class API
    
    convenience init<T: Codable>(settings: T) {
        let title = "Settings"
        if let item = ItemParser().makeItem(from: settings, name: title),
            case .items(let items) = item.value {
            self.init(title: title, items: items)
        } else {
            fatalError()
        }
    }
    
    let items: [Item]
    
    init(title: String, items: [Item]) {
        self.items = items
        super.init(nibName: nil, bundle: Bundle(for: Self.self))
        self.title = title
	}

	required init?(coder aDecoder: NSCoder) { fatalError() }
    
    var onSave: (() -> Void)?

	// MARK: - Outlets

	@IBOutlet private var tableView: UITableView!

	// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLeftItem()
        configureTable()
        configureSaveButton()
    }
    
    // MARK: - Private
    
    private var dataSource: ItemsDataSource!
    
    private func configureLeftItem() {
        if let controllers = navigationController?.viewControllers, controllers.count == 1 {
            navigationItem.leftBarButtonItem = makeCancelItem()
        }
    }

    private func configureTable() {
        dataSource = ItemsDataSource(items: items)
        dataSource.hook(with: tableView)
        dataSource.onOpenDetail = pushController
    }
    
    private func pushController(title: String, items: [Item]) {
        let controller = SettingsViewController(title: title, items: items)
        controller.onSave = onSave
        show(controller, sender: self)
    }
    
    private func configureSaveButton() {
        let saveButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = saveButtonItem
    }
    
    @objc func save() {
        onSave?()
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    private func makeCancelItem() -> UIBarButtonItem {
        return UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
    }
    
}
