//
//  LandingView.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/12/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

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
                                        
                                        NavigationLink(destination: SignInView(), isActive: $isLinkActive) {
                                            Button(action: {self.isLinkActive = true}){
                                                Text("Login")
                                            }.buttonStyle(.borderedProminent)
                                                .buttonBorderShape(.roundedRectangle(radius: 10))
                                        }
                                        
                                        NavigationLink(destination: SignUpView(), isActive: $isLinkActive2) {
                                            Button(action: {self.isLinkActive2 = true}){
                                                Text("SignUp")
                                            }.buttonStyle(.borderedProminent)
                                                .buttonBorderShape(.roundedRectangle(radius: 10))
                                        }
                                        
                                    }
                                    
                                    GoogleSignInButton{}
                                    
                                }
                                                           
                            }.padding(10)
                        )
                    }
                ).padding(25)
            }
        
        }
        
    }

}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
