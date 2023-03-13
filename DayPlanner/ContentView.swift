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
}

struct ContentView: View {
    var body: some View {
        VStack{
            BottomBar(
                AnyView(List()),
                AnyView(Planner()),
                AnyView(Settings())
            )
            .environmentObject(AppVariables())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
