//
//  Planner.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI

struct Planner: View {
    
//    @State var items : [PlannerModel] = [
//        PlannerModel(id: "1", data: ["name" : "TestName", "time" : "12:00am"]),
//        PlannerModel(id: "2", data: ["name" : "This is a test", "time" : "1:00am"]),
//        PlannerModel(id: "3", data: ["name" : "TestName", "time" : "2:00am"]),
//        PlannerModel(id: "4", data: ["name" : "", "time" : "3:00am"]),
//        PlannerModel(id: "5", data: ["name" : "", "time" : "4:00am"]),
//        PlannerModel(id: "6", data: ["name" : "TestName", "time" : "5:00am"]),
//        PlannerModel(id: "7", data: ["name" : "", "time" : "6:00am"]),
//        PlannerModel(id: "8", data: ["name" : "", "time" : "7:00am"]),
//        PlannerModel(id: "9", data: ["name" : "", "time" : "8:00am"]),
//        PlannerModel(id: "10", data: ["name" : "", "time" : "9:00am"]),
//        PlannerModel(id: "11", data: ["name" : "", "time" : "10:00am"]),
//        PlannerModel(id: "12", data: ["name" : "TestName", "time" : "11:00am"]),
//        PlannerModel(id: "13", data: ["name" : "TestName", "time" : "12:00pm"]),
//        PlannerModel(id: "14", data: ["name" : "This is a test", "time" : "1:00pm"]),
//        PlannerModel(id: "15", data: ["name" : "TestName", "time" : "2:00pm"]),
//        PlannerModel(id: "16", data: ["name" : "", "time" : "3:00pm"]),
//        PlannerModel(id: "17", data: ["name" : "", "time" : "4:00pm"]),
//        PlannerModel(id: "18", data: ["name" : "TestName", "time" : "5:00pm"]),
//        PlannerModel(id: "19", data: ["name" : "", "time" : "6:00pm"]),
//        PlannerModel(id: "20", data: ["name" : "", "time" : "7:00pm"]),
//        PlannerModel(id: "21", data: ["name" : "", "time" : "8:00pm"]),
//        PlannerModel(id: "22", data: ["name" : "", "time" : "9:00pm"]),
//        PlannerModel(id: "23", data: ["name" : "", "time" : "10:00pm"]),
//        PlannerModel(id: "24", data: ["name" : "", "time" : "11:00pm"])
//    ]
    
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
                            PlannerCard(eventName: "Test", time: "\(i):00")
                        }
                        
//                        ForEach(items, id: \.self.id){
//                            (plannerModel: PlannerModel) in PlannerCard(plannerModel: plannerModel)
//                        }
                        
                    }
        
                } // end of ScrollView
                
                
            } // end of VStack
            
            
        } // end of ZStack
        
        
    } // end of body
    
    
} // end of View

struct Planner_Previews: PreviewProvider {
    static var previews: some View {
        Planner()
    }
}
