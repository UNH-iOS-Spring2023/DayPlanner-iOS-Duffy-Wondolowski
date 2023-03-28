//
//  ContentView.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AppVariables: ObservableObject {
    @Published var selectedTab: Int = 0
    //Determines whether the app goes to the edit event page when the list is selected
    @Published var isEventEdit: Bool = false
    @Published var eventList: [Event] = []
    @Published var selectedEvent: Event? = nil
    @Published var user: User = User()
    
    var uid: String? = nil
    
    func checkEventOverlap(newEvent: Event, oldEvent: Event? = nil) -> Bool {
        //True means there is no overlap
        return ErrorChecking.checkEventOverlap(eventList: eventList, newEvent: newEvent, oldEvent: oldEvent)
    }
    
    func checkTime() {
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.startOfDay(for: Date())
//        print("Day Planner: start of day: \(date)")
//        print("Day Planner: eventsLastCleared: \(user.eventsLastCleared)")
        if user.eventsLastCleared < date {
            eventList = eventList.filter { event in
                event.recurring != 0
            }
        }
    }
}

struct ContentView: View {
    @StateObject var app = AppVariables()
    @Environment(\.scenePhase) private var scenePhase
    let db = Firestore.firestore()
    
    var body: some View {
        
        VStack{
            BottomBar(
                AnyView(EventList()),
                AnyView(Planner()),
                AnyView(Settings())
            )
            .environmentObject(app)
        }
        .onAppear() {
            app.uid = Auth.auth().currentUser?.uid
            
            if app.uid == nil {
//                Persistence.load{ (userResult, eventResult) in
////                                print("Full load user result: \(userResult)")
////                                print("Full load event result: \(eventResult)")
//                    switch userResult {
//                    case .failure(let error):
//                        print("Error loading users: \(error.localizedDescription)")
//                    case .success(let user):
//                        app.user = user
//                    }
//
//                    switch eventResult {
//                    case .failure(let error):
//                        print("Error loading events: \(error.localizedDescription)")
//                    case .success(let events):
//                        app.eventList = events
//                    }
//                }
//                do {
//                    let eventData = UserDefaults.standard.value(forKey: "eventList")
//                    app.eventList = try
//                    Firestore.Decoder().decode([Event].self, from: eventData ?? [])
//
//                    let userData = UserDefaults.standard.value(forKey: "user")
//                    app.user = try
//                    Firestore.Decoder().decode(User.self, from: userData ?? User())
//                } catch {
//                    print("Error saving data: \(error.localizedDescription)")
//                }
            } else {
                db.collection("Users/\(app.uid!)/events")
                    .getDocuments() { (events, err) in
                        if let err = err {
                            print("Error getting events: \(err)")
                        } else {
                            for event in events!.documents {
                                do {
                                    app.eventList
                                        .append(try event.data(as: Event.self))
                                } catch {
                                    print("Error converting db event: \(error)")
                                }
                            }
                        }
                    }
                db.collection("Users").document(app.uid!)
                    .getDocument(as: User.self) { result in
                        switch result {
                        case .success(let user): app.user = user
                        case.failure(let error):
                            print("Error getting user: \(error)")
                        }
                }
            }
            app.checkTime()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
//                Persistence.save(user: app.user, events: app.eventList) { (userResult, eventResult) in
//                    if case .failure(let error) = userResult {
//                    print("Error saving users: \(error.localizedDescription)")
//                    }
//
//                    if case .failure(let error) = eventResult {
//                    print("Error saving events: \(error.localizedDescription)")
//                    }
//                do {
//                    let eventData = try Firestore.Encoder().encode(app.eventList)
//                    UserDefaults.standard.set(eventData, forKey: "eventList")
//
//                    let userData = try Firestore.Encoder().encode(app.user)
//                    UserDefaults.standard.set(userData, forKey: "user")
//                } catch {
//                    print("Error saving data: \(error.localizedDescription)")
//                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
