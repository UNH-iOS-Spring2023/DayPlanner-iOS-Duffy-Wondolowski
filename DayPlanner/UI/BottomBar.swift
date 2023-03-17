//
//  BottomBar.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI

//Mostly copied from professor's example, with modifications to suit our app
struct BottomBar: View {
    
    @EnvironmentObject private var app: AppVariables
    
    let ListView : AnyView
    let PlannerView : AnyView
    let SettingsView : AnyView
    
    init(
    // Initialize all parameters for our bottom bar
        _ ListView : AnyView,
        _ PlannerView : AnyView,
        _ SettingsView : AnyView
    ){
        self.ListView = ListView
        self.PlannerView = PlannerView
        self.SettingsView = SettingsView
    }
    
    
    var body: some View {
        TabView(selection: $app.selectedTab){
            
            ListView
                .tabItem{
                    Image(systemName: "list.bullet")
                    Text("List")
                }
                .tag(0)
            
            PlannerView
                .tabItem{
                    Image(systemName: "clock")
                        .environment(\.symbolVariants, .none)
                    Text("Planner")
                }
                .tag(1)
            
            SettingsView
                .tabItem{
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(2)
        }
    }
}

struct BottomBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomBar(
            AnyView(EventList()),
            AnyView(Planner()),
            AnyView(Settings())
        )
        .environmentObject(AppVariables())
    }
}

