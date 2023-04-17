//
//  EventEdit.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/13/23.
//

import SwiftUI
import FirebaseFirestore
import GooglePlaces

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
    
    //    @State private var placeSearch = false
    
    @State private var predictions: [String] = []
    @FocusState private var locationFocused: Bool
    
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
                    .foregroundColor(.white)
                
                Card(
                    cornerRadius: 15,
                    elevation: 3,
                    width: CGFloat.infinity,
                    height: 80,
                    color: CustomColor.backgroundCard,
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
                ).padding(5)
                
                
                VStack{
                    Text("Event Duration")
                        .foregroundColor(.white)
                    
                    
                    Slider(value: $duration, in: 5...360)
                    if (duration < 60) {
                        Text("\(Int(duration)) Minutes")
                            .foregroundColor(.white)
                    } else {
                        Text("\(Int(duration / 60)) Hours \(Int(duration) % 60) Minutes")
                            .foregroundColor(.white)
                    }
                    
                }
                
                VStack {
                    Toggle("Start Time (Optional)", isOn: $showStartTime)
                        .onChange(of: showStartTime) { showStartTime in
                            if showStartTime { if startTime == nil { startTime = Date()}}
                            else { startTime = nil }
                        }
                        .foregroundColor(.white)
                    if (showStartTime) {
                        DatePicker("Please enter a time",
                                   selection: Binding(get: {self.startTime ?? Date()}, set: {self.startTime = $0}),
                                   displayedComponents: .hourAndMinute
                        )
                    }
                }
                if app.user.locationServices == true {
                    VStack {
                        HStack {
                            CustomTextField(
                                placeHolder: "Location (Optional)",
                                imageName: "",
                                bColor: "textColorWhite",
                                tOpacity: 0.6,
                                width: CGFloat.infinity,
                                height: 40,
                                borderColor: CustomColor.backgroundCard,
                                value: $location
                            )
                            .focused($locationFocused)
                            //                                Button(action: maps, label: { Image(systemName: "location.circle") })
                        }.padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                        if locationFocused {
                            List {
                                ForEach(predictions, id: \.self) { prediction in
                                    HStack {
                                        Text(prediction)
                                            .font(.system(size: 14))
                                            .foregroundColor(.white)
                                    }
                                    .onTapGesture {
                                        location = prediction
                                    }
                                    //                                        .listRowInsets(EdgeInsets(top: -20, leading: -20, bottom: -20, trailing: -20))
                                    .listRowBackground(CustomColor.backgroundCard)
                                }
                            }
                            .listStyle(PlainListStyle())
                            .background(CustomColor.background)
                            .onChange(of: location) { location in updateLocPredictions()}
                        }
                    }
                }
                Spacer()
                
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
    
    ///Updates location predictions based on the location variable that was typed
    private func updateLocPredictions() {
        app.placesClient.findAutocompletePredictions(fromQuery: location,
                                                     filter: GMSAutocompleteFilter(),
                                                     sessionToken: app.token,
                                                     callback: { (results, error) in
            if let error = error {
                print("Autocomplete error: \(error)")
                return
            }
            if let results = results {
                predictions = []
                for result in results {
                    predictions.append(result.attributedFullText.string)
                }
            }
        })
    }
    
    ///Enter the google maps view
    private func maps() {
        //        placeSearch = true
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
            
            if event != Event(),
               let eventIndex = app.eventList.firstIndex(where: { $0.id == self.event.id }) {
                
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
        if event != Event(), let eventIndex = app.eventList.firstIndex(where: { $0.id == self.event.id }) {
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
