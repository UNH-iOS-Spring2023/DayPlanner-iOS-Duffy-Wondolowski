//
//  SignUpView.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/5/23.
//

import SwiftUI

struct SignUpView: View {
    
    @State var isLinkActive = false;
    
    @State var txtEmail: String = ""
    @State var txtFullName: String = ""
    @State var txtUsername: String = ""
    @State var txtPassword: String = ""
    @State var txtPasswordConfirm: String = ""
    
    var body: some View {
                
        NavigationView {
            
            
            Card(
                cornerRadius: 15,
                elevation: 3,
                height: 450,
                color: Color(.white),
                focusColor: Color(.systemRed).opacity(0.05),
                views: {
                    AnyView(
                        VStack(spacing: 20){
                            
                            Text("Welcome to Sign Up!")
                            
                            VStack (spacing: 20){
                                
                                CustomTextField(
                                    placeHolder: "Email",
                                    imageName: "envelope",
                                    bColor: "textColorBlack",
                                    tOpacity: 0.6,
                                    width: CGFloat.infinity,
                                    height: 40,
                                    value: $txtEmail
                                )
                                CustomTextField(
                                    placeHolder: "Full Name",
                                    imageName: "person.fill",
                                    bColor: "textColorBlack",
                                    tOpacity: 0.6,
                                    width: CGFloat.infinity,
                                    height: 40,
                                    value: $txtFullName
                                )
                                CustomTextField(
                                    placeHolder: "Username",
                                    imageName: "person",
                                    bColor: "textColorBlack",
                                    tOpacity: 0.6,
                                    width: CGFloat.infinity,
                                    height: 40,
                                    value: $txtUsername
                                )
                                CustomTextField(
                                    placeHolder: "Password",
                                    imageName: "lock.fill",
                                    bColor: "textColorBlack",
                                    tOpacity: 0.6,
                                    width: CGFloat.infinity,
                                    height: 40,
                                    value: $txtPassword
                                )
                                CustomTextField(
                                    placeHolder: "Password Confirm",
                                    imageName: "lock",
                                    bColor: "textColorBlack",
                                    tOpacity: 0.6,
                                    width: CGFloat.infinity,
                                    height: 40,
                                    value: $txtPasswordConfirm
                                )
                                
                            }
                            
                            HStack{
                                                
                                Button(action: signUp){
                                    Text("Sign Up")
                                }.buttonStyle(.borderedProminent)
                                    .buttonBorderShape(.roundedRectangle(radius: 10))
                                
                            }
                                        
                        }.padding(10)
                    )
                }
            ).padding(15)
            
        }
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
