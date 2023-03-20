//
//  PlannerCard.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/19/23.
//

import SwiftUI

struct PlannerCard: View {
    
    let eventName: String
    let time: String
    
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
                                    
                                    Text(time)
                                        .foregroundColor(.white)
                                        .font(.system(size:18))
                                        .multilineTextAlignment(.center)
                                        .padding(5)
                                )
                            }
                        ).padding(5)
                        
                        Spacer()
                        
                        Text(eventName)
                            .foregroundColor(.white)
                            .font(.system(size:18))
                            .bold()
                            .padding(10)
             
                    }
                )
            }
        ).padding(EdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10))
        
        
        
    }
}

struct PlannerCard_Previews: PreviewProvider {
    static var previews: some View {
        PlannerCard(eventName: "Holder", time: "Holder")
//        PlannerCard(plannerModel : PlannerModel(id: "1", data: ["name" : "TestName", "time" : "12:00am"]))
//            .environmentObject(AppVariables())
    }
}
