//
//  Settings.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI

struct Settings: View {
    
    @State var username: String = "Username"
    @State var fullname: String = "Fullname"
    @State var email: String = "Email"
    
    @State private var endNotifications = false
    @State private var location = false
    @State private var startNotifications = false
    
    var body: some View {
        
        ZStack{
            CustomColor.background
                .ignoresSafeArea(.all)
            
            VStack{
                
                Text("User Information: ")
                    .foregroundColor(.white)
                    .font(.system(size:20))
                
                Card(
                    cornerRadius: 15,
                    elevation: 5,
                    height: 125,
                    color: CustomColor.backgroundCard,
                    views: {
                        AnyView(
                            
                            HStack {
                                
                                VStack {
                                    Text(username)
                                        .foregroundColor(.white)
                                    Text(email)
                                        .foregroundColor(.white)
                                }
                                
                                Text(fullname)
                                    .foregroundColor(.white)
                                
                            }
                            
                        )
                        
                    }
                )
                
                Text("Preferences: ")
                    .foregroundColor(.white)
                    .font(.system(size:20))
                
                Card(
                    cornerRadius: 15,
                    elevation: 5,
                    height: 250,
                    color: CustomColor.backgroundCard,
                    views: {
                        AnyView(
                            
                            VStack{
                                
                                Toggle("Start Notfications:", isOn: $startNotifications)
                                    .padding(15)
                                    .foregroundColor(.white)
                                Toggle("End Notfications:", isOn: $endNotifications)
                                    .padding(15)
                                    .foregroundColor(.white)
                                Toggle("Enable Location Services:", isOn: $location)
                                    .padding(15)
                                    .foregroundColor(.white)
                            }
                            
                            
                        )
                    }
                )
                
                
                
                
                
            }.padding(25) // end of VStack
            
        } // end of ZStack
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
