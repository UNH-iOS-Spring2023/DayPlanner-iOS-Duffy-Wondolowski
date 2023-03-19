//
//  ListItem.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/16/23.
//

import SwiftUI

struct ListItem: View {
    @EnvironmentObject var app: AppVariables
    let event: Event
    
    var body: some View {
        EventCard(event: event, click: clickEvent)
    }
    
    
    func clickEvent() {
        app.selectedEvent = event
        app.isEventEdit = true
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(event: Event())
            .environmentObject(AppVariables())
    }
}
