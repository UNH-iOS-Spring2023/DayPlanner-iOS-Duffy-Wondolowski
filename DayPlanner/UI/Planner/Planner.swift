//
//  Planner.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI

struct Planner: View {
    var body: some View {
        ZStack {
            
            CustomColor.background
                .ignoresSafeArea(.all)
            
            Text("Planner Page")
                .foregroundColor(.white)
        }
    }
}

struct Planner_Previews: PreviewProvider {
    static var previews: some View {
        Planner()
    }
}
