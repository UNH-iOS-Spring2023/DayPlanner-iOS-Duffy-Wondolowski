//
//  SignUpView.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/5/23.
//

import SwiftUI

struct SignUpView: View {
    
    @State var txtEmail: String = ""
    @State var txtFullName: String = ""
    @State var txtUsername: String = ""
    @State var txtPassword: String = ""
    @State var txtPasswordConfirm: String = ""
    
    var body: some View {
        VStack {
            Text("Welcome to Sign Up!")
            
            VStack{
                
                CustomTextField(
                    placeHolder: "Email",
                    imageName: "envelope",
                    bColor: "textColorBlack",
                    tOpacity: 0.6,
                    value: $txtEmail
                )
                CustomTextField(
                    placeHolder: "Full Name",
                    imageName: "person.fill",
                    bColor: "textColorBlack",
                    tOpacity: 0.6,
                    value: $txtFullName
                )
                CustomTextField(
                    placeHolder: "Username",
                    imageName: "person",
                    bColor: "textColorBlack",
                    tOpacity: 0.6,
                    value: $txtUsername
                )
                CustomTextField(
                    placeHolder: "Password",
                    imageName: "lock.fill",
                    bColor: "textColorBlack",
                    tOpacity: 0.6,
                    value: $txtPassword
                )
                CustomTextField(
                    placeHolder: "Password Confirm",
                    imageName: "lock",
                    bColor: "textColorBlack",
                    tOpacity: 0.6,
                    value: $txtPasswordConfirm
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

func signInLink(){
    
    
    
}

func signUpLink(){
    
    
    
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
