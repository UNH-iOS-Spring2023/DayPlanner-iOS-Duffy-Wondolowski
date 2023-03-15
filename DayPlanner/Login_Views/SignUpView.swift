//
//  SignUpView.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/5/23.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    @State var isLinkActive = false;
    
    @State var txtEmail: String = ""
    @State var txtFullName: String = ""
    @State var txtUsername: String = ""
    @State var txtPassword: String = ""
    @State var txtPasswordConfirm: String = ""
    
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
                    height: 450,
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
                                        placeHolder: "Full Name",
                                        imageName: "person.fill",
                                        bColor: "textColorBlack",
                                        tOpacity: 0.6,
                                        width: CGFloat.infinity,
                                        height: 40,
                                        borderColor: CustomColor.background,
                                        value: $txtFullName
                                    )
                                    CustomTextField(
                                        placeHolder: "Username",
                                        imageName: "person",
                                        bColor: "textColorBlack",
                                        tOpacity: 0.6,
                                        width: CGFloat.infinity,
                                        height: 40,
                                        borderColor: CustomColor.background,
                                        value: $txtUsername
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
                                        placeHolder: "Password Confirm",
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
                                    
                                }
                                            
                            }.padding(15)
                        )
                    }
                ).padding(25)
            }
        }
            
        
    }
    
    func signUp(){
        
//        Auth.auth().createUser(withEmail: txtEmail, password: txtPassword){ result, error in
//            if error != nil{
//                print(error!.localizedDescription)
//            }
//        }
        
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
