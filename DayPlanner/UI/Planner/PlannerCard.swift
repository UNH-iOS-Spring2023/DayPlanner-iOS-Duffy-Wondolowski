//
//  PlannerCard.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/19/23.
//

import SwiftUI
import UserNotifications

/// This is the UI element for the PlannerCard
/// - Parameters:
///     - eventName: The name of the event
///     - time: The time that the event begins

struct PlannerCard: View {
    
    let event: Event
    
    init(event: Event) {
        self.event = event
    }
    
    var body: some View {
        
        let currentTime = Date()
        let startTime: Date? = event.startTime
        let duration = event.duration / 1000 // has to be divided by 1000 since the TimeInterval method is in seconds
        let timeInterval: TimeInterval = TimeInterval(duration)
        
        let endTime: Date? = startTime?.addingTimeInterval(timeInterval)
        
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
                                        
                                        if let startTime = startTime{
                                            let dateString = DateFormatter.localizedString(from: startTime, dateStyle: .none, timeStyle: .short)
                                            
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
                
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                    if granted {
                        print("User granted notification permissions")
                    } else {
                        print("User did not grant notification permissions")
                    }
                }
                
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    
                    if Date() == startTime {
                        self.sendNotification()
                        timer.invalidate()
                    }
                    
                } // end of timer
                
            } // end of onAppear
        

   
    } // end of body
    
    func sendNotification() { // code in part from Kavsoft tutorial https://www.youtube.com/watch?v=BW9dVMNNpkY
        
        let content = UNMutableNotificationContent()
        content.title = "Event Starting Now!"
        content.body = "This is a notification that your event has begun!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "eventStartingNow", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error sending notification: \(error.localizedDescription)")
            } else {
                print("Notification sent")
            }
        }
        
    } // end of sendNotifications function
 
} // end of View

struct PlannerCard_Previews: PreviewProvider {
    static var previews: some View {
        PlannerCard(event: Event(eventName: "Event Name"))
            .environmentObject(AppVariables())
    }
}
