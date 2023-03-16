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
            height: 150,
            color: CustomColor.backgroundCard,
            views: {
                AnyView(
                    VStack (spacing: 15){
                        
                        Text("Welcome to DayPlanner!")
                            .foregroundColor(.white)
                        
                                                   
                    }.padding(10)
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
