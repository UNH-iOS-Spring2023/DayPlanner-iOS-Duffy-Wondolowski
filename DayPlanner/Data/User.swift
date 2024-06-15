//
//  User.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/17/23.
//

import Foundation

struct User: Codable, Equatable {
    var defaultScreen: Int = 0
    var startNotifications: Bool = false
    var endNotifications: Bool = false
    var locationServices: Bool = false
    var eventsLastCleared: Date = Date()
}
