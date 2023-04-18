//
//  SignInWithGoogle.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 4/16/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

class SignInWithGoogle: ObservableObject {
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
                let idToken = user.idToken else { return }
            
            let accessToken = user.accessToken
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { res, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = res?.user else { return }
                print(user)
                
            } // end of Auth Sign In
            
        } // end of GIDSignIn sharedInstance
    }
}
