//
//  Planner.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI

struct Planner: View {
    
    @State var AmPm : String = "am"
    @State var event : String = "Test Event Name"
    @State var time : Int = 0
        
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
                    
                    VStack{
                        ForEach(1..<25){ i in
//                            if i <= 12 {
//                                AmPm = "pm"
//                            }  
                            PlannerCard(eventName: "\(event)", time: "\(i):00\(AmPm)")
                        }
                    }
                        
        
                } // end of ScrollView
                
                
            } // end of VStack
            
            
        } // end of ZStack
        
        
    } // end of body
    
    
    func addEventToPlanner(){
        
    }
    
    
} // end of View

struct Planner_Previews: PreviewProvider {
    static var previews: some View {
        Planner()
    }
}
