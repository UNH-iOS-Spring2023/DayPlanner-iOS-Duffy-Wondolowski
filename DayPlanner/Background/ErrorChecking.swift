//
//  ErrorChecking.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/14/23.
//

import Foundation

struct ErrorChecking {
    static func checkEventOverlap(eventList: [Event], newEvent: Event, oldEvent: Event? = nil) -> Bool { //True means there is no overlap
        if newEvent.startTime == nil {
            //If the new event does not have a start time, then there cannot be an overlap
            return true
        }
        if oldEvent != nil, eventList.contains(
            where: {oldEvent != $0 && !checkTimeOverlap(newEvent: newEvent, oldEvent: $0)}) {
            return false
        } else if oldEvent == nil, eventList.contains(
            where: {!checkTimeOverlap(newEvent: newEvent, oldEvent: $0)}) {
            return false
        } else {
            return true
        }
    }
    
    static private func checkTimeOverlap(newEvent: Event, oldEvent: Event) -> Bool { //True means there is no overlap
        if (oldEvent.startTime == nil) {
            return true
        }
        
        if newEvent.startTime! == oldEvent.startTime! {
            return false
        } else if newEvent.startTime! < oldEvent.startTime!,
           newEvent.startTime!.distance(to: oldEvent.startTime!) < TimeInterval(newEvent.duration / 1000) {
            return false
        } else if newEvent.startTime! > oldEvent.startTime!,
                  oldEvent.startTime!.distance(to: newEvent.startTime!) < TimeInterval(oldEvent.duration / 1000) {
            return false
        } else {
            return true
        }
    }
}
