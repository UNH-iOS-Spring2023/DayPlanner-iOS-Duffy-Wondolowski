//
//  PlannerCard.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/19/23.
//

import SwiftUI




struct PlannerCard: View {
    
    let event: Event
    
    init(event: Event) {
        self.event = event
    }
    
    var body: some View {
        
        let date: Date? = event.startTime
        let duration = event.duration / 1000 // has to be divided by 1000 since the TimeInterval method is in seconds
        let timeInterval: TimeInterval = TimeInterval(duration)
        
        let endTime: Date? = date?.addingTimeInterval(timeInterval)
        
        Card(
            cornerRadius: 15,
            elevation: 3,
            height: 100,
            color: CustomColor.background,
            views: {
                AnyView(
                    HStack {
                        
                        Card(
                            cornerRadius: 15,
                            elevation: 5,
                            width: 115,
                            height: 80,
                            color: CustomColor.background,
                            views: {
                                AnyView(
                                    
                                    VStack {
                                        
                                        if let date = date{
                                            let dateString = DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .short)
                                            
                                            Text(dateString)
                                                .foregroundColor(.white)
                                                .font(.system(size:18))
                                                .multilineTextAlignment(.center)
                                            .padding(5)
                                            
                                            Spacer()
                                                                                        
                                            let dateStringEnd = DateFormatter.localizedString(from: endTime!, dateStyle: .none, timeStyle: .short)
                                            
                                            Text(dateStringEnd)
                                                .foregroundColor(.white)
                                                .font(.system(size:18))
                                                .multilineTextAlignment(.center)
                                            .padding(5)
                                            
                                        }
                                    }
                                )
                            }
                        ).padding(8)
                        
                        Spacer()
                        
                        Text(event.eventName)
                            .foregroundColor(.white)
                            .font(.system(size:18))
                            .bold()
                            .padding(10)
             
                    }
                )
            }
        ).padding(EdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10))
            .onAppear{
                startNotifications()
                endNotifications()
            }
        
        
        
    } // end of body
    
    
    func getTime() -> String {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            let dateString = formatter.string(from: Date())
            return dateString
        } // end of getTime function
        
    func startNotifications() {
        
        let start: Date? = event.startTime
        
        let startTimeShort = DateFormatter.localizedString(from: start!, dateStyle: .none, timeStyle: .short)
        
        if startTimeShort == getTime(){
            let content = UNMutableNotificationContent()
            content.title = event.eventName
            content.subtitle = "Your Event Has Begun"
            content.sound = .default
            content.badge = 1

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request)
        }
        
    } // end of startNotifications function
    
    func endNotifications() {
           
           let start: Date? = event.startTime
           let duration = event.duration / 1000 // has to be divided by 1000 since the TimeInterval method is in seconds
           let timeInterval: TimeInterval = TimeInterval(duration)
           
           let end: Date? = start?.addingTimeInterval(timeInterval)
           
           let endTimeShort = DateFormatter.localizedString(from: end!, dateStyle: .none, timeStyle: .short)
           
           if startTimeShort == getTime(){
               
               let content = UNMutableNotificationContent()
               content.title = event.eventName
               content.subtitle = "Your Event Has Ended!"
               content.sound = .default
               content.badge = 1

               let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

               let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

               UNUserNotificationCenter.current().add(request)
           }
           
       } // end of endNotifications function

} // end of View




/// This is the UI element for the PlannerCard
/// - Parameters:
///     - eventName: The name of the event
///     - time: The time that the event begins

//struct PlannerCard: View {
//
//    let eventName: String
//    let time: String
//
//    var body: some View {
//
//        Card(
//            cornerRadius: 15,
//            elevation: 3,
//            height: 80,
//            color: CustomColor.background,
//            views: {
//                AnyView(
//                    HStack {
//
//                        Card(
//                            cornerRadius: 15,
//                            elevation: 3,
//                            width: 115,
//                            height: 40,
//                            color: CustomColor.background,
//                            views: {
//                                AnyView(
//
//                                    Text(time)
//                                        .foregroundColor(.white)
//                                        .font(.system(size:18))
//                                        .multilineTextAlignment(.center)
//                                        .padding(5)
//                                )
//                            }
//                        ).padding(8)
//
//                        Spacer()
//
//                        Text(eventName)
//                            .foregroundColor(.white)
//                            .font(.system(size:18))
//                            .bold()
//                            .padding(10)
//
//                    }
//                )
//            }
//        ).padding(EdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10))
//
//
//
//    }
//}

struct PlannerCard_Previews: PreviewProvider {
    static var previews: some View {
        PlannerCard(event: Event(eventName: "Event Name"))
            .environmentObject(AppVariables())
        
        
//        PlannerCard(planner: PlannerModel(startTime: "1:00am", eventName: "Holder"))
//            .environmentObject(AppVariables())
        
        
//        PlannerCard(planner: PlannerModel(startTime: "1:00am", endTime: "2:00am", eventName: "Holder"))
//            .environmentObject(AppVariables())
        
        
        
//        PlannerCard(plannerModel : PlannerModel(id: "1", data: ["name" : "TestName", "time" : "12:00am"]))
//            .environmentObject(AppVariables())
    }
}
