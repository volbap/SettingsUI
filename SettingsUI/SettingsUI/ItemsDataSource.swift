//
//  ItemsDataSource.swift
//  SettingsUI
//
//  Created by Pablo Villar on Mar 22, 2020.
//  Copyright © 2020 volbap. All rights reserved.
//

import UIKit

class ItemsDataSource: NSObject {
    
    let items: [Item]
    
    init(items: [Item]) {
        self.items = items
    }
    
    typealias OpenDetailHandler = (_ title: String, _ items: [Item]) -> Void
    var onOpenDetail: OpenDetailHandler?
    
    func hook(with tableView: UITableView) {
        tableView.register(SwitchCell.self)
        tableView.register(NumericCell.self)
        tableView.register(TextCell.self)
        tableView.register(GroupCell.self)
        tableView.rowHeight = 44.0
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ItemsDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item.value {
        case .bool(let value):
            let cell = tableView.dequeue(SwitchCell.self)!
            cell.configure(title: item.name, value: value)
            cell.onChange = { item.value = .bool($0) }
            return cell
        case .number(let value):
            let cell = tableView.dequeue(NumericCell.self)!
            cell.configure(title: item.name, value: value)
            cell.onChange = { item.value = .number($0) }
            return cell
        case .string(let value):
            let cell = tableView.dequeue(TextCell.self)!
            cell.configure(title: item.name, value: value)
            cell.onChange = { item.value = .string($0) }
            return cell
        case .items(_):
            let cell = tableView.dequeue(GroupCell.self)!
            cell.configure(title: item.name)
            return cell
        case .unknown:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        if case .items(let subitems) = item.value {
            onOpenDetail?(item.name, subitems)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
