//
//  EventCard.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/15/23.
//

import SwiftUI

struct EventCard: View {
    
    let event: Event
    let click: ()-> Void
    
    init(event: Event, click: @escaping () -> Void = {}) {
        self.event = event
        self.click = click
    }
    
    var body: some View {
        
        Card(
            cornerRadius: 15,
            elevation: 3,
            height: 100,
            color: CustomColor.backgroundCard,
            click: self.click,
            views: {
                AnyView(
                    HStack {
                        VStack (spacing: 15){
                            
                            Text(event.eventName)
                                .foregroundColor(.white)
                                .font(.system(size:20))
                                .bold()
                            
                            listTime()
                                .foregroundColor(.white)
                                .font(.system(size:10))
                                                       
                        }.padding(10)
                        
                        Card(
                            cornerRadius: 15,
                            elevation: 3,
                            width: 150,
                            height: 50,
                            color: CustomColor.background,
                            views: {
                                AnyView(
                                    
                                    location()
                                        .foregroundColor(.white)
                                        .font(.system(size:20))
                                    
                                )
                            }
                        )
                        
             
                    }
                )
            }
        ).padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))    
    }
    
    func listTime() -> Text {
        let duration = event.duration / 60000
        if (duration < 60) {
            return Text("\(Int(duration)) Minutes")
        } else {
            return Text("\(Int(duration / 60)) Hours \(Int(duration) % 60) Minutes")
        }
    }
    
    func location() -> Text {
        if event.location == "" {
            return Text("No Location")
        } else {
            return Text(event.location)
        }
            
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(event: Event(eventName: "Event Name", location: "Event Location"))
    }
}
