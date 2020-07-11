//
//  Optional.swift
//  495-project-2
//
//  Created by ADF on 3/2/20.
//  Copyright © 2020 ADF. All rights reserved.
//

import Foundation


extension Optional where Wrapped == String {
    var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}
extension Optional where Wrapped == Int {
    var _bound: String? {
        get {
            return "\(self.bound)"
        }
        set {
            self = Int(newValue ?? "0")
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}

