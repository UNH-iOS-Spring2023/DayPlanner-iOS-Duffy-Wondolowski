//
//  ScrollDropDelegate.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/16/23.
//

import SwiftUI

//Idea came from several places, with main inspiration taken from https://stackoverflow.com/questions/72384177/swiftui-drag-and-drop-reorder-detect-object-release
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
            //.move shifts the destination event and everything beyond it forward to move the dragged event there
            //So if you're going backwards items get shifted forwards past the dragged event as soon as you land on them
            //But if you're going forwards the dragged event is not moved until you completely pass the item,
            //Because the item you're at will be pushed forwards, so you need to add 1 to the destination in that case
            eventList.wrappedValue.move(fromOffsets: IndexSet(integer: origin), toOffset: destination < origin ? destination : destination + 1)
        }
    }
    
}

//Idea originates from https://stackoverflow.com/questions/64723631/swiftui-drag-drop-item-provider-not-called-consistently-by-the-system
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
