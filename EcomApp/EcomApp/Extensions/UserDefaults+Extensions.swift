//
//  UserDefaults+Extensions.swift
//  EcomApp
//
//  Created by Md.Sourav on 5/6/25.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let userId = "userId"
    }
    
    var userId : Int? {
        get {
            let id = integer(forKey: Keys.userId)
            return id == 0 ? nil : id
        }
        set {
            set(newValue, forKey: Keys.userId)
        }
    }
}
