//
//  SignInView.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/5/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct SignInView: View {
    
    @State var txtUsername: String = ""
    @State var txtPassword: String = ""
    
    var body: some View {
        
            
        Card(
            cornerRadius: 15,
            elevation: 5,
            height: 300,
            color: Color(.white),
            views: {
                AnyView(
                    VStack (spacing: 15){
                        
                        Text("Sign In!")
                        
                        Text("Welcome to DayPlanner!")
                        
                        CustomTextField(
                            placeHolder: "Username",
                            imageName: "person",
                            bColor: "textColorBlack",
                            tOpacity: 0.6,
                            width: CGFloat.infinity,
                            height: 40,
                            borderColor: Color(.systemBlue),
                            value: $txtUsername
                        )

                        CustomTextField(
                            placeHolder: "Password",
                            imageName: "lock",
                            bColor: "textColorBlack",
                            tOpacity: 0.6,
                            width: CGFloat.infinity,
                            height: 40,
                            borderColor: Color(.systemBlue),
                            value: $txtPassword
                        )

                        
                        Button(action: signIn){
                            Text("Login")
                        }.buttonStyle(.borderedProminent)
                            .buttonBorderShape(.roundedRectangle(radius: 10))
                        
                        
                    }.padding(15)
                )
            }
        ).padding(25)
        
            

    }
}
    

func signIn(){
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}