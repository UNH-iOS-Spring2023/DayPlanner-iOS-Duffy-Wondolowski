//
//  ContentView.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ContentView: View {
    @EnvironmentObject var app: AppVariables
    @Environment(\.scenePhase) private var scenePhase
    var db = Firestore.firestore()
    
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
            app.checkTime()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                Persistence.save(user: app.user, events: app.eventList) { (userResult, eventResult) in
                    if case .failure(let error) = userResult {
                        print("Error saving users: \(error.localizedDescription)")
                    }
                    
                    if case .failure(let error) = eventResult {
                        print("Error saving events: \(error.localizedDescription)")
                    }
//                    do {
//                        let eventData = try Firestore.Encoder().encode(app.eventList)
//                        UserDefaults.standard.set(eventData, forKey: "eventList")
//                        
//                        let userData = try Firestore.Encoder().encode(app.user)
//                        UserDefaults.standard.set(userData, forKey: "user")
//                    } catch {
//                        print("Error saving data: \(error.localizedDescription)")
//                    }
                }
            }
        }
        .onChange(of: app.uid) { uid in
            if app.uid == nil {
                app.eventList = []
                app.user = User()
            } else {
//                print("Day Planner: UID no longer nil, beginning midsession login sequence")
                db.collection("Users").document(app.uid!)
                    .getDocument(as: User.self) { result in
                        switch result {
                        case .success(let user): app.user = user
                            print("Day Planner: Firestore eventsLastCleared: \(user.eventsLastCleared)")
                        case.failure(let error):
                            print("Error getting user: \(error)")
                        }
                    }
                
                for event in app.eventList {
                    do {
                        try db.collection("Users/\(app.uid!)/events")
                            .document(event.id!).setData(from:event)
                    }
                    catch {
                        print("Error uploading event to database: \(error.localizedDescription)")
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
                                    var newEvent = try event.data(as: Event.self)
                                    newEvent.id = event.documentID
                                    app.eventList
                                        .append(newEvent)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
