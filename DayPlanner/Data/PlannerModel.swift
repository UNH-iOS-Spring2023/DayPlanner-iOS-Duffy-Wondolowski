//
//  PlannerModel.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/19/23.
//

import UserNotifications

class PlannerModel{
    
    var events: [Event] = []
    
    func scheduleNotifications(for time: Date) {
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            } else if granted {
                print("Notification authorization granted")
            } else {
                print("Notification authorization denied")
            }
            
        } // end of requestAuthorization
        
        let calendar = Calendar.current
        let eventStartTimeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        for event in events {
            
            let eventStartTime = calendar.date(byAdding: eventStartTimeComponents, to: event.startTime!)!
            if eventStartTime > time {
                let content = UNMutableNotificationContent()
                content.title = "Upcoming Event: \(event.eventName)"
                content.body = "Your event starts at \(DateFormatter.localizedString(from: event.startTime!, dateStyle: .none, timeStyle: .short))"
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
            
        } // end of for loop
        
    } // end of scheduleNotifications function
    
    
    
}
