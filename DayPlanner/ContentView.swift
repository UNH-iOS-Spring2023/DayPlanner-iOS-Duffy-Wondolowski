//
//  ContentView.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI

class AppVariables: ObservableObject {
    @Published var selectedTab: Int = 0
    //Determines whether the app goes to the edit event page when the list is selected
    @Published var isEventEdit: Bool = false
    @Published var eventList: [Event] = []
    @Published var selectedEvent: Event? = nil
    @Published var user: User = User()
    
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
            Persistence.load{ (userResult, eventResult) in
//                                print("Full load user result: \(userResult)")
//                                print("Full load event result: \(eventResult)")
                                switch userResult {
                                case .failure(let error):
                                    fatalError(error.localizedDescription)
                                case .success(let user):
                                    app.user = user
                                }
                
                                switch eventResult {
                                case .failure(let error):
                                    fatalError(error.localizedDescription)
                                case .success(let events):
                                    app.eventList = events
                                }
                            }
            app.checkTime()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                Persistence.save(user: app.user, events: app.eventList) { (userResult, eventResult) in
                    if case .failure(let error) = userResult {
                    fatalError(error.localizedDescription)
                    }
                    
                    if case .failure(let error) = eventResult {
                    fatalError(error.localizedDescription)
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
