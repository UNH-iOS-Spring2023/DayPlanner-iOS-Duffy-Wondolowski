//
//  Event.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/13/23.
//

import Foundation

struct Event: Equatable, Hashable {
    var startTime: Date? = nil
    var duration: Int = 900000 //Stored in milliseconds for compatibility with android
    var eventName: String = ""
    var location: String = ""
    var recurring: Int = 0
}
