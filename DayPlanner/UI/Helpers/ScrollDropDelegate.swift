//
//  ScrollDropDelegate.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/16/23.
//

import SwiftUI

struct ScrollDropDelegate: DropDelegate {
    var droppedOnEvent: Event
    var eventList: Binding<[Event]>
    var draggedEvent: Binding<Event?>
    
    ///Resets the dragged event if the event is released
    func performDrop(info: DropInfo) -> Bool {
        draggedEvent.wrappedValue = nil
        return true
    }
    
    ///Try to move the event if the user drags it
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    ///Attempt to change the order of events if the event is dragged over another event
    func dropEntered(info: DropInfo) {
        if draggedEvent.wrappedValue != droppedOnEvent {
            let origin = eventList.wrappedValue.firstIndex(of: draggedEvent.wrappedValue!)!
            let destination = eventList.wrappedValue.firstIndex(of: droppedOnEvent)!
            eventList.wrappedValue.move(fromOffsets: IndexSet(integer: origin), toOffset: destination)
        }
    }
    
}

struct DropOutsideDelegate: DropDelegate {
    var draggedEvent: Binding<Event?>
    
    ///Resets the dragged event if the event is released
    func performDrop(info: DropInfo) -> Bool {
        draggedEvent.wrappedValue = nil
        return true
    }
    
    ///Try to move the event if the user drags it
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
}
