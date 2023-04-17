//
//  EventEdit.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/13/23.
//

import SwiftUI
import FirebaseFirestore

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
    
    @State private var event: Event = Event()
    
    @State private var eventName: String
    @State private var duration: Double
    @State private var startTime: Date?
    @State private var location: String
    @State private var recurring: Int
    @State private var showStartTime: Bool
    @State private var createAlert: Bool = false
    @State private var alertText = ""
    
    let db = Firestore.firestore()
    
    init(event: Event = Event()) {
        _eventName = State(initialValue: event.eventName)
        _duration = State(initialValue: Double(event.duration / 60000))
        _startTime = State(initialValue: event.startTime)
        _location = State(initialValue: event.location)
        _recurring = State(initialValue: event.recurring)
        _showStartTime = State(initialValue: event.startTime != nil)
        self.event = event
    }
    
    var body: some View {
        ZStack {
            
            CustomColor.background
                .ignoresSafeArea(.all)
            
            VStack {
                Text("Event Customization")
                    .foregroundColor(CustomColor.darkGreen)
                
                Card(
                    cornerRadius: 15,
                    elevation: 10,
                    width: CGFloat.infinity,
                    height: 80,
                    color: CustomColor.background,
                    views: {
                        AnyView(
                            CustomTextField(
                                placeHolder: "Event Name (Required)",
                                imageName: "",
                                bColor: "textColorWhite",
                                tOpacity: 0.6,
                                width: CGFloat.infinity,
                                height: 40,
                                borderColor: CustomColor.background,
                                value: $eventName
                            ).padding(10)
                        )
                    }
                ).padding(5) // end of Event Name Card
                
                Text("Event Duration")
                    .foregroundColor(CustomColor.darkGreen)
                
                Card(
                    cornerRadius: 15,
                    elevation: 10,
                    width: CGFloat.infinity,
                    height: 130,
                    color: CustomColor.background,
                    views: {
                        AnyView(
                            VStack{
                                
                                Slider(value: $duration, in: 5...360)
                                
                                if (duration < 60) {
                                    Text("\(Int(duration)) Minutes")
                                        .foregroundColor(.white)
                                } else {
                                    Text("\(Int(duration / 60)) Hours \(Int(duration) % 60) Minutes")
                                        .foregroundColor(.white)
                                }
                                
                            }.padding(5)
                        )
                    }
                ).padding(5) // end of Slider Card
                
                
                Text("Event Start Time")
                    .foregroundColor(CustomColor.darkGreen)
                
                Card(
                    cornerRadius: 15,
                    elevation: 10,
                    width: CGFloat.infinity,
                    height: 150,
                    color: CustomColor.background,
                    views: {
                        AnyView(
                            VStack {
                                Toggle("Start Time (Optional)", isOn: $showStartTime)
                                    .padding(10)
                                    .foregroundColor(.white)
                                    .onChange(of: showStartTime) { showStartTime in
                                        if showStartTime { startTime = Date()}
                                        else { startTime = nil }
                                    }
                                if (showStartTime) {
                                    DatePicker("Enter the Time:",
                                               selection: Binding(get: {self.startTime ?? Date()}, set: {self.startTime = $0}),
                                               displayedComponents: .hourAndMinute
                                    ).foregroundColor(.white)
                                        .padding(10)
                                }
                            }
                        )
                    }
                ).padding(5) // end of StartTime Card
                
                Spacer()
                
                Card(
                    cornerRadius: 15,
                    elevation: 10,
                    width: CGFloat.infinity,
                    height: 80,
                    color: CustomColor.background,
                    views: {
                        AnyView(
                            HStack {
                                Button ("Cancel", action: cancel)
                                    .foregroundColor(Color(.systemOrange))
                                Button ("Create", action: create)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                    .alert(isPresented: $createAlert) {
                                        Alert(title: Text(alertText))
                                    }
                                Button ("Delete", action: delete)
                                    .foregroundColor(Color(.systemRed))
                            }
                        )
                    }
                ).padding(5) // end of Button Card
                
            }
            .font(.system(.title))
            .padding(EdgeInsets(top: 10, leading: 25, bottom: 25, trailing: 10))
            .onAppear() {
                event = app.selectedEvent ?? Event()
                eventName = event.eventName
                duration = Double(event.duration / 60000)
                startTime = event.startTime
                location = event.location
                recurring = event.recurring
                showStartTime = event.startTime != nil
        }
        }
    }
    
    ///Forget any changes made and return to the event list view
    private func cancel() {
        app.isEventEdit = false
        app.selectedEvent = nil
    }
    
    ///Create the event. Automatically checks to see if this event is a modification of an old event, and acts accordingly
    private func create() {
        
        if eventName != "" {
            let newEvent = Event(
                id: event.id ?? db.collection("Users").document().documentID,
                startTime: showStartTime ? startTime : nil,
                duration: Int(duration * 60000),
                eventName: eventName,
                location: location,
                recurring: recurring)
            
            if let eventIndex = app.eventList.firstIndex(where: { $0 == self.event }) {
                
                if app.checkEventOverlap(newEvent: newEvent, oldEvent: app.eventList[eventIndex]) {
                    app.eventList[eventIndex] = newEvent
                    app.isEventEdit = false
                    app.selectedEvent = nil
                    
                    uploadEvent(newEvent: newEvent)
                    print("Event created with id: \(newEvent.id ?? "Error: no ID")")
                } else {
                    alertText = "Your event overlaps with another!"
                    createAlert = true
                }
            } else {
                
                if app.checkEventOverlap(newEvent: newEvent) {
                    app.eventList.append(newEvent)
                    app.isEventEdit = false
                    app.selectedEvent = nil
                    
                    uploadEvent(newEvent: newEvent)
                    print("Event created with id: \(newEvent.id ?? "Error: no ID")")
                } else {
                    alertText = "Your event overlaps with another!"
                    createAlert = true
                }
            }
        } else {
            alertText = "Your event requires a name!"
            createAlert = true
        }
    }
    
    ///Delete the currently edited event. Works the same as cancel if the event is a new one
    private func delete() {
        if event != Event(), let eventIndex = app.eventList.firstIndex(where: { $0 == self.event }) {
            deleteEvent()
            app.eventList.remove(at: eventIndex)
        }
        app.isEventEdit = false
        app.selectedEvent = nil
    }
    
    ///Upload the event to Firestore
    private func uploadEvent(newEvent: Event) {
        if app.uid != nil {
            do {
                try db.collection("Users/\(app.uid!)/events")
                    .document(newEvent.id!).setData(from:newEvent)
            }
            catch {
                print("Error uploading event to database: \(error.localizedDescription)")
            }
        }
    }
    
    ///Delete the event from Firestore
    private func deleteEvent() {
        db.collection("Users/\(app.uid!)/events").document(event.id!).delete() {
            err in
            if let err = err {
                print("Error deleting document: \(err.localizedDescription)")
            } else {
                print("Document successfully removed")
            }
        }
    }
}

struct EventEdit_Previews: PreviewProvider {
    static var previews: some View {
        EventEdit()
            .environmentObject(AppVariables())
    }
}
