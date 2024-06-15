//
//  EventCard.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/15/23.
//

import SwiftUI

/// This is the UI element for the EventCard
/// - Parameters:
///     - event: The name of the event
///     - click: The function that is called after the card is clicked

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
            color: CustomColor.background,
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
                        
                        Spacer()
                        
                        Card(
                            cornerRadius: 15,
                            elevation: 3,
                            width: 150,
                            height: 50,
                            color: CustomColor.darkGreen,
                            click: self.openMaps,
                            views: {
                                AnyView(
                                    
                                    location()
                                        .foregroundColor(.white)
                                        .font(.system(size:20))
                                    
                                )
                            }
                        ).padding(10)
             
                    }
                )
            }
        ).padding(EdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10))
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
    
    private func openMaps() {
        let preppedAddress = event.location.replacingOccurrences(of: " ", with: "+")
        
        let googleMapsUrl = URL(string: "comgooglemaps://?saddr=&daddr=\(preppedAddress)&directionsmode=driving")!
        let appleMapsUrl = URL(string: "maps://?saddr=&daddr=\(preppedAddress)")!
        
        if UIApplication.shared.canOpenURL(googleMapsUrl) {
            UIApplication.shared.open(googleMapsUrl)
        } else if UIApplication.shared.canOpenURL(appleMapsUrl) {
            UIApplication.shared.open(appleMapsUrl)
        } else {
            UIApplication.shared.open(URL(string: "https://www.google.com/maps/place/\(preppedAddress)")!)
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard(event: Event(eventName: "Event Name", location: "Event Location"))
    }
}
