//
//  SignInView.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/5/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignInView: View {
    @EnvironmentObject private var app: AppVariables
    
    let db = Firestore.firestore()
    
    @State var txtEmail: String = ""
    @State var txtPassword: String = ""
    
    @State private var alertText = ""
    @State private var createAlert: Bool = false
    
    var body: some View {
        
        
        
        ZStack {
            
            CustomColor.background
                .ignoresSafeArea(.all)
            
            VStack {
                
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                Card(
                    cornerRadius: 15,
                    elevation: 5,
                    height: 300,
                    color: CustomColor.backgroundCard,
                    views: {
                        AnyView(
                            VStack (spacing: 15){
                                
                                Text("Sign In!")
                                    .foregroundColor(.white)
                                
                                Text("Welcome to DayPlanner!")
                                    .foregroundColor(.white)
                                
                                CustomTextField(
                                    placeHolder: "Email",
                                    imageName: "envelope",
                                    bColor: "textColorBlack",
                                    tOpacity: 0.6,
                                    width: CGFloat.infinity,
                                    height: 40,
                                    borderColor: CustomColor.background,
                                    value: $txtEmail
                                )
                                
                                CustomTextField(
                                    placeHolder: "Password",
                                    imageName: "lock",
                                    bColor: "textColorBlack",
                                    tOpacity: 0.6,
                                    width: CGFloat.infinity,
                                    height: 40,
                                    borderColor: CustomColor.background,
                                    value: $txtPassword
                                )
                                
                                
                                Button(action: signIn){
                                    Text("Login")
                                }.buttonStyle(.borderedProminent)
                                    .buttonBorderShape(.roundedRectangle(radius: 10))
                                    .alert(isPresented: $createAlert){
                                        Alert(title: Text(alertText))
                                    }
                                
                                
                            }.padding(15)
                        )
                    }
                ).padding(25)
            }
        }
    }
    
    /// This function logs a users into their account using the emnail and password they have entered
    
    func signIn(){
        Auth.auth().signIn(withEmail: txtEmail, password: txtPassword) { result, err in
            if let err = err{
                print("Failed to login user!: ", err)
                alertText = "Failed to login! The username or password is incorrect!"
                createAlert = true
                return
            } else {
                print("Successfully logged in in the User!")
                
                app.uid = result?.user.uid ?? nil
                
                print("User ID: " + (app.uid ?? "None"))
                
            }
        }
        txtEmail = ""
        txtPassword = ""
    }
    
    
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(AppVariables())
    }
}
