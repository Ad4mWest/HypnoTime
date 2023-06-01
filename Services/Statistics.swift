//  Statistics.swift
//  MotivationTimer
//  Created by Adam West on 23.05.23.


import UIKit

final class Statistics {
    
    private let userDefaults = UserDefaults.standard
    private enum Keys: String {
        case total
    }
    var defaultAmount = 0
}

extension Statistics {
    var total: Int {
        get {
            if userDefaults.integer(forKey: Keys.total.rawValue) == 0 {
                return defaultAmount + 1
            }
            return userDefaults.integer(forKey: Keys.total.rawValue)
        }
        set (total) {
            userDefaults.set(total, forKey: Keys.total.rawValue)
        }
    }
}
