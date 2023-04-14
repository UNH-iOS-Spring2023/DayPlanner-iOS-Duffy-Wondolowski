//
//  PlannerItem.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 4/2/23.
//

import SwiftUI

struct PlannerItem: View {
    
    @EnvironmentObject var app: AppVariables
    let event: Event
    
    var body: some View {
        PlannerCard(event: event)
    }
}

struct PlannerItem_Previews: PreviewProvider {
    static var previews: some View {
        PlannerItem(event: Event())
            .environmentObject(AppVariables())
    }
}
