//
//  Planner.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI

struct Planner: View {
    
    @EnvironmentObject private var app: AppVariables
        
    var body: some View {
        ZStack (alignment: .top){
            
            CustomColor.background
                .ignoresSafeArea(.all)
            
            VStack {
                
                Card(
                    cornerRadius: 15,
                    elevation: 3,
                    width: 300,
                    height: 60,
                    color: CustomColor.background,
                    views: {
                        AnyView(
                            Text(Date.now, format: .dateTime.day().month().year())
                                .foregroundColor(.white)
                                .font(.system(size:18))
                                .multilineTextAlignment(.center)
                        )
                    }
                )
                
                ScrollView {
                    
                    VStack(spacing: 10) {
                        ForEach(app.eventList, id: \.self.id) {
                            (event: Event) in PlannerItem(event: event)
                        }
                    }
                    
                    
                    
//                    VStack{
//                        ForEach(1..<25){ i in
//                            if i > 13 {
//                                PlannerCard(eventName: "\(event)", time: "\(i - 13):00pm")
//                            } else if i == 1 {
//                                PlannerCard(eventName: "\(event)", time: "\(i + 11):00am")
//                            } else if i == 13 {
//                                PlannerCard(eventName: "\(event)", time: "\(i - 1):00pm")
//                            } else {
//                                PlannerCard(eventName: "\(event)", time: "\(i-1):00am")
//                            }
//                        }.onAppear{
//                            
//                        }
//                    } // end of VStack
                    
        
                } // end of ScrollView
                
                
            } // end of VStack
            
            
        } // end of ZStack
       
        
    } // end of body
    
    
} // end of View

struct Planner_Previews: PreviewProvider {
    static var previews: some View {
        Planner()
            .environmentObject(AppVariables())
    }
}
