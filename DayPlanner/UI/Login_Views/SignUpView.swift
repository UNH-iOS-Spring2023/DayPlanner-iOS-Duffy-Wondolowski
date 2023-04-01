//
//  SignUpView.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/5/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    
    let db = Firestore.firestore()
    
    @State var txtEmail: String = ""
    @State var txtPassword: String = ""
    @State var txtPasswordConfirm: String = ""
    
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
                    height: 375,
                    color: CustomColor.backgroundCard,
                    views: {
                        AnyView(
                            
                            VStack(spacing: 20){
                                
                                Text("Sign Up!")
                                    .foregroundColor(.white)
                                
                                Text("Welcome to DayPlanner!")
                                    .foregroundColor(.white)
                                
                                VStack (spacing: 20){
                                    
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
                                        imageName: "lock.fill",
                                        bColor: "textColorBlack",
                                        tOpacity: 0.6,
                                        width: CGFloat.infinity,
                                        height: 40,
                                        borderColor: CustomColor.background,
                                        value: $txtPassword
                                    )
                                    CustomTextField(
                                        placeHolder: "Confirm Password",
                                        imageName: "lock",
                                        bColor: "textColorBlack",
                                        tOpacity: 0.6,
                                        width: CGFloat.infinity,
                                        height: 40,
                                        borderColor: CustomColor.background,
                                        value: $txtPasswordConfirm
                                    )
                                    
                                }
                                
                                HStack{
                                    
                                    Button(action: signUp){
                                        Text("Sign Up")
                                    }.buttonStyle(.borderedProminent)
                                        .buttonBorderShape(.roundedRectangle(radius: 10))
                                        .alert(isPresented: $createAlert){
                                            Alert(title: Text(alertText))
                                        }
                                    
                                }
                                
                            }.padding(15)
                        )
                    }
                ).padding(25)
            }
        
            
        } // End of ZStack
        
        
    }
    
    
    /// This function checks to see if the two password fields match one another.
    ///    If the fields match then it calls the userAuth() function
    ///    If the fields do not match then it sends an alert to the user informing them their passwords dont match

    private func signUp(){
        if txtPassword == txtPasswordConfirm {
            userAuth()
        } else {
            alertText = "Your Passwords Don't Match!"
            createAlert = true
        }
    }
    
    /// This function creates a user's account to Firebase
    ///    The account is created with the Users Email and their password
    
    private func userAuth(){
        
        Auth.auth().createUser(withEmail: txtEmail, password: txtPassword){ result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Successfully created Account: \(result?.user.uid ?? "")")
                self.userToFirestore()
            }

        }
        
    }
    
    /// This function addes a users UID to the FireStore database

    private func userToFirestore(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        txtEmail = ""
        txtPassword = ""
        txtPasswordConfirm = ""
        
    }
    
    
    
    
    
    
    
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
