//
//  ErrorChecking.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/14/23.
//

import Foundation

struct ErrorChecking {
    ///Check to ensure that there is no overlap in time between a new event to be added and the already existing events
    /// - Parameter oldEvent: If the new event is overwriting an old event, the old event is passed so it can be excluded from the check
    /// - Returns: True if there is no overlap, false if there is
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
    
    ///A helper function that checks the time overlap for an individual event
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
