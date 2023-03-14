//
//  EventEdit.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/13/23.
//

import SwiftUI

//extension Int {
//    //toDouble modified from https://ootips.org/yonat/swiftui-binding-type-conversion/
//    var toDouble: Double {
//        get {Double(self)}
//        set {self = Int(newValue)}
//    }
//    //for converting from milliseconds to minutes
//    var toMin: Int {
//        get { self / 60000}
//        set {self = newValue * 60000}
//    }
//}
struct EventEdit: View {
    @EnvironmentObject private var app: AppVariables
    var event: Event = Event()
    @State private var eventName: String
    @State private var duration: Double
    @State private var startTime: Date?
    @State private var location: String
    @State private var recurring: Int
    @State private var showStartTime: Bool
    
    init() {
        _eventName = State(initialValue: event.eventName)
        _duration = State(initialValue: Double(event.duration / 60000))
        _startTime = State(initialValue: event.startTime)
        _location = State(initialValue: event.location)
        _recurring = State(initialValue: event.recurring)
        _showStartTime = State(initialValue: event.startTime != nil ? true : false)
    }
    
    var body: some View {
        VStack {
            Text("Event Customization")
            TextField("Event Title", text: $eventName)
            
            VStack{
                Text("Event Duration")
                Slider(value: $duration, in: 5...360)
                Text("\(Int(duration)) Minutes")
            }
            
            VStack {
                Toggle("Start Time (Optional)", isOn: $showStartTime)
                if (showStartTime) {
                    DatePicker("Please enter a time",
                               selection: Binding(get: {self.startTime ?? Date()}, set: {self.startTime = $0}),
                               displayedComponents: .hourAndMinute
                    )
                }
            }
            Spacer()
        }
        .font(.system(.title))
        .padding(EdgeInsets(top: 10, leading: 25, bottom: 25, trailing: 10))
    }
}

struct EventEdit_Previews: PreviewProvider {
    static var previews: some View {
        EventEdit()
            .environmentObject(AppVariables())
    }
}
