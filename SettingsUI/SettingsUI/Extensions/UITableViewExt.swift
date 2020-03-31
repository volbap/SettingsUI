//
//  UITableViewExt.swift
//  SettingsUI
//
//  Created by Pablo Villar on Mar 22, 2020.
//  Copyright © 2020 volbap. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeue<T: UITableViewCell>(_ type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(UINib(nibName: T.identifier, bundle: Bundle(for: type)), forCellReuseIdentifier: T.identifier)
    }
    
}

extension UITableViewCell {
    
    class var identifier: String {
        return String.className(for: self)
    }
    
}

extension String {
    
    static func className(for aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last ?? ""
    }
    
}
