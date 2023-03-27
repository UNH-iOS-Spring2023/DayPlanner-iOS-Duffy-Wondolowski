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
    
    
    
    private func signUp(){
        if txtPassword == txtPasswordConfirm {
            userAuth()
        } else {
            alertText = "Your Passwords Don't Match!"
            createAlert = true
        }
    }
    
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
    
    private func userToFirestore(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //Next part is disabled because none of this is stuff we should be storing in the database anyway
//        let userData = [
//            "email": self.txtEmail,
//            "fullname": self.txtFullName,
//            "username": self.txtUsername,
//            "uid": uid ]
//        db.collection("Users")
//            .document(uid).setData(userData){ err in
//                if let err = err {
//                    print(err)
//                    return
//                }
//                print("Success")
//            }
        
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
