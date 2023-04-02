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
