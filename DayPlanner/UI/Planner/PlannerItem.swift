//
//  PlannerItem.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 4/2/23.
//

import SwiftUI

struct PlannerItem: View {
    
    @EnvironmentObject var app: AppVariables
    let planner: PlannerModel
    
    var body: some View {
        PlannerCard(planner: planner)
    }
}

struct PlannerItem_Previews: PreviewProvider {
    static var previews: some View {
        PlannerItem(planner: PlannerModel())
            .environmentObject(AppVariables())
    }
}
