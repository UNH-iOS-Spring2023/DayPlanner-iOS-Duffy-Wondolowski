//
//  SignInView.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/5/23.
//

import SwiftUI

struct SignInView: View {
    
    @State var txtUsername: String = ""
    @State var txtPassword: String = ""
    
    var body: some View {
        
        VStack{
            
            Text("Welcome to DayPlanner!")
            
            VStack{
                
                CustomTextField(
                    placeHolder: "Username",
                    imageName: "person",
                    bColor: "textColorBlack",
                    tOpacity: 0.6,
                    value: $txtUsername
                )
                CustomTextField(
                    placeHolder: "Password",
                    imageName: "lock",
                    bColor: "textColorBlack",
                    tOpacity: 0.6,
                    value: $txtPassword
                )
                
            }
            
            HStack{
                
                
                
                Button(action: signIn){
                    Text("Login")
                }.buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                
                Button(action: signUp){
                    Text("Sign Up")
                }.buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                
            }
            
        }.padding()
        
    }
    
}

func signIn(){
    
    
    
}

func signUp(){
    
    
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
