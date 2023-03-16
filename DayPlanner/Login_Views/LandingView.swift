//
//  LandingView.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/12/23.
//

import SwiftUI
//import FirebaseCore
//import FirebaseAuth
//import GoogleSignIn
//import GoogleSignInSwift

struct LandingView: View {
    
    @State var isLinkActive = false;
    @State var isLinkActive2 = false;
    
    @State var txtUsername: String = ""
    @State var txtPassword: String = ""
    
    var body: some View {
            
        NavigationView {
            
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
                        elevation: 3,
                        height: 150,
                        color: CustomColor.backgroundCard,
                        views: {
                            AnyView(
                                VStack (spacing: 15){
                                    
                                    Text("Welcome to DayPlanner!")
                                        .foregroundColor(.white)
                                    
                                    VStack {
                                        
                                        HStack {
                                            
                                            NavigationLink(destination: SignInView()) {
                                                Text("Login")
                                                    .frame(width: 150, height: 35)
                                                    .background(CustomColor.background)
                                                    .cornerRadius(15)
                                                    .foregroundColor(.white)
                                            }
                                            NavigationLink(destination: SignUpView()) {
                                                Text("SignUp")
                                                    .frame(width: 150, height: 35)
                                                    .background(CustomColor.background)
                                                    .cornerRadius(15)
                                                    .foregroundColor(.white)
                                            }
                                        
                                        }
                                        
    //                                        Spacer()
    //
    //                                        GoogleSignInButton{}
    //                                            .cornerRadius(10)
                                        
                                    }
                                                               
                                }.padding(10)
                            )
                        }
                    ).padding(25)
                }
            }
        
        }
        
    }

}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
