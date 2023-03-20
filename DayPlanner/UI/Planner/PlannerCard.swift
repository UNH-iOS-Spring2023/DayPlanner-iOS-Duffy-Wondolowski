//
//  PlannerCard.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/19/23.
//

import SwiftUI

struct PlannerCard: View {
    
//    let event: Event
//
//    init(event: Event){
//        self.event = event
//    }
    
    @EnvironmentObject private var app : AppVariables
    @ObservedObject var plannerModel : PlannerModel
    
    var body: some View {
        
        Card(
            cornerRadius: 15,
            elevation: 3,
            height: 80,
            color: CustomColor.background,
            views: {
                AnyView(
                    HStack {
                        
                        Card(
                            cornerRadius: 15,
                            elevation: 3,
                            width: 115,
                            height: 40,
                            color: CustomColor.background,
                            views: {
                                AnyView(
                                    
                                    Text(plannerModel.time)
                                        .foregroundColor(.white)
                                        .font(.system(size:18))
                                        .multilineTextAlignment(.center)
                                )
                            }
                        ).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        Spacer()
                        
                        Text(plannerModel.name)
                            .foregroundColor(.white)
                            .font(.system(size:20))
                            .bold()
                            .padding(10)
             
                    }
                )
            }
        )
    }
}

struct PlannerCard_Previews: PreviewProvider {
    static var previews: some View {
        PlannerCard(plannerModel : PlannerModel(id: "1", data: ["name" : "TestName", "time" : "12:00am"]))
            .environmentObject(AppVariables())
    }
}
