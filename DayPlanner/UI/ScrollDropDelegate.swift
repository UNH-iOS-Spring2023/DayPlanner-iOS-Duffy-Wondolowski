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
    
    
    func performDrop(info: DropInfo) -> Bool {
        draggedEvent.wrappedValue = nil
        return true
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func dropEntered(info: DropInfo) {
        if draggedEvent.wrappedValue != droppedOnEvent {
            let origin = eventList.wrappedValue.firstIndex(of: draggedEvent.wrappedValue!)!
            let destination = eventList.wrappedValue.firstIndex(of: droppedOnEvent)!
            eventList.wrappedValue.move(fromOffsets: IndexSet(integer: origin), toOffset: destination)
        }
    }
    
}
