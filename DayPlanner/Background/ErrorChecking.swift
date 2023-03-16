//
//  ErrorChecking.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/14/23.
//

import Foundation

class ErrorChecking {
    
    var eventList: [Event] = []
    
    func checkEventOverlap(newEvent: Event, oldEvent: Event? = nil) -> Bool { //True means there is no overlap
        if newEvent.startTime == nil {
            //The whole point of this is to check for overlap, so it should not be run if that is not possible
            print("Error: attempting to check overlap for event that does not have a start time")
            return false
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
    
    private func checkTimeOverlap(newEvent: Event, oldEvent: Event) -> Bool { //True means there is no overlap
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
