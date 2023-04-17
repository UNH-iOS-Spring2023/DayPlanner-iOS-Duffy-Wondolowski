//
//  PlannerModel.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/19/23.
//

import UserNotifications

class PlannerModel: ObservableObject{
    
    @Published var events: [Event] = []
    
    func scheduleNotifications() {
        
            let center = UNUserNotificationCenter.current()
        
            center.requestAuthorization(options: [.alert, .sound]) { granted, error in
                if let error = error {
                    print("Error requesting notification authorization: \(error.localizedDescription)")
                } else if granted {
                    print("Notification authorization granted")
                } else {
                    print("Notification authorization denied")
                }
                
            }
            
            let calendar = Calendar.current
            
            for event in events {
                
                guard let startTime = event.startTime else { continue }
                let eventStartTimeComponents = calendar.dateComponents([.hour, .minute], from: startTime)
                let eventStartTime = calendar.date(byAdding: eventStartTimeComponents, to: startTime)!
                
                if eventStartTime > Date() {
                    
                    let content = UNMutableNotificationContent()
                    content.title = "Upcoming Event: \(event.eventName)"
                    content.body = "Your event starts at \(DateFormatter.localizedString(from: startTime, dateStyle: .none, timeStyle: .short))"
                    content.sound = .default
                    
                    let triggerDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: eventStartTime)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: event.eventName, content: content, trigger: trigger)
                    center.add(request) { error in
                        if let error = error {
                            print("Error scheduling notification for event \(event.eventName): \(error.localizedDescription)")
                        } else {
                            print("Notification scheduled for event \(event.eventName)")
                        }
                        
                    }
                    
                }
                
            }
        
        } // end of scheduleNotifications function
    
    
    
}
