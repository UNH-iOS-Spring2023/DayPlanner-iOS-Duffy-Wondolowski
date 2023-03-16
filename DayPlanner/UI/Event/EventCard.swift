//
//  EventCard.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/15/23.
//

import SwiftUI

struct EventCard: View {
    
    var body: some View {
        
        Card(
            cornerRadius: 15,
            elevation: 3,
            height: 100,
            color: CustomColor.backgroundCard,
            views: {
                AnyView(
                    HStack {
                        VStack (spacing: 15){
                            
                            Text("EventName")
                                .foregroundColor(.white)
                                .font(.system(size:20))
                                .bold()
                            
                            Text("Event Duration")
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
                                    
                                    Text("Event Location")
                                        .foregroundColor(.white)
                                        .font(.system(size:20))
                                    
                                )
                            }
                        )
                        
             
                    }
                )
            }
        ).padding(25)    
    }
}

struct EventCard_Previews: PreviewProvider {
    static var previews: some View {
        EventCard()
    }
}
