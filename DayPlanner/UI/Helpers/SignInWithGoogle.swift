//
//  SignInWithGoogle.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 4/16/23.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseCore
import FirebaseAuth 

class SignInWithGoogle: ObservableObject {
    @EnvironmentObject private var app: AppVariables
    @Published var isLoginSuccessful = false
    
    func signInGoogle() {
        // app client id.
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Google Sign In configurable object
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // sign in method
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { user, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard
                let user = user?.user,
                let idToken = user.idToken?.tokenString else{return}
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { [self] res, error in
                if let error = error {
                    print("FirseBase Sign-in failed with this error")
                    print(error.localizedDescription)
                    return
                }
                
                if let user = res?.user {
                    print("Sign in Complete : \(user.email ?? "")")
                    self.isLoginSuccessful = true
                }
//                app.uid = res?.user.uid ?? nil
                
            } // end of Auth Sign In
            
        } // end of GIDSignIn sharedInstance
    }
}
