//
//  SplashScreenView.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/15/23.
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
    
    @Published var uid: String? = nil
    
    ///Check to ensure that there is no overlap in time between a new event to be added and the already existing events
    /// - Parameter oldEvent: If the new event is overwriting an old event, the old event is passed so it can be excluded from the check
    /// - Returns: True if there is no overlap, false if there is
    func checkEventOverlap(newEvent: Event, oldEvent: Event? = nil) -> Bool {
        //True means there is no overlap
        return ErrorChecking.checkEventOverlap(eventList: eventList, newEvent: newEvent, oldEvent: oldEvent)
    }
    
    ///Check if the day has changed since the last time events were cleared, and clear non-recurring events if it has
    func checkTime() {
        let db = Firestore.firestore()
        
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.startOfDay(for: Date())
//        print("Day Planner: start of day: \(date)")
//        print("Day Planner: eventsLastCleared: \(user.eventsLastCleared)")
        
        if user.eventsLastCleared < date {
//            print("Day Planner: Clearing events due to the day changing")
//            print(eventList)
            
            user.eventsLastCleared = Date()
            
            if uid != nil {
                let oldEvents = eventList.filter { event in
                    event.recurring == 0
                }
                
                for event in oldEvents {
                    db.collection("Users/\(uid!)/events")
                        .document(event.id!).delete() { err in
                            if let err = err {
                                print("Error deleting event from database: \(err.localizedDescription)")
                            }
                        }
                }
                
                do {
                    try db.collection("Users")
                        .document(uid!).setData(from:user)
                    
                    print("User updated after clearing events")
                }
                catch {
                    print("Error updating user in database: \(error.localizedDescription)")
                }
            }
            
            eventList = eventList.filter { event in
                event.recurring != 0
            }
        }
    }
}


struct SplashScreenView: View {
    
    @State var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    @StateObject var app = AppVariables()
    
    let db = Firestore.firestore()
    
    var body: some View {
        if isActive {
            ContentView().environmentObject(app)
        } else {
            VStack{
                CustomColor.background
                    .ignoresSafeArea(.all)
                    .overlay {
                        VStack{
                            Image("Logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 350)
                        }.scaleEffect(size)
                            .opacity(opacity)
                            .onAppear{
                                withAnimation(.easeIn(duration: 1.2)){
                                    self.size = 0.9
                                    self.opacity = 1.00
                                }
                            }
                    }
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation{
                        self.isActive = true
                    }
                }
                
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
                    db.collection("Users").document(app.uid!)
                        .getDocument(as: User.self) { result in
                            switch result {
                            case .success(let user): app.user = user
                                print("Day Planner: Firestore eventsLastCleared: \(user.eventsLastCleared)")
                            case.failure(let error):
                                print("Error getting user: \(error)")
                            }
                        }
                    
                    app.eventList = []
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
                }
                
            }
            
        }
        
        
        
        
        
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
