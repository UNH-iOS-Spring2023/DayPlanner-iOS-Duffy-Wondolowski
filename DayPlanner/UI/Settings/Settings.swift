//
//  Settings.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct Settings: View {
    @EnvironmentObject var app: AppVariables
    
    let db = Firestore.firestore()
    
    @State private var endNotifications = false
    @State private var location = false
    @State private var startNotifications = false
    
    @State private var alertText = ""
    @State private var createAlert: Bool = false
    
    var body: some View {
        
        ZStack{
            CustomColor.background
                .ignoresSafeArea(.all)
            
            VStack (spacing: 20){
                
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                VStack {
                                   
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
                                    
                                    if app.uid == nil {
                                        VStack {
                                                HStack {
                                                    
                                                    NavigationLink(
                                                        destination: SignInView().environmentObject(app)) {
                                                            Text("Login")
                                                                .frame(width: 150, height: 35)
                                                                .background(CustomColor.background)
                                                                .cornerRadius(15)
                                                                .foregroundColor(.white)
                                                        }
                                                    NavigationLink(
                                                        destination: SignUpView().environmentObject(app)) {
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
                                                //
                                        }
                                    } else {
                                        Text("User: " + (Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? ""))
                                            .foregroundColor(.white)
                                            .font(.title2)
                                    }
                                }
                            )
                        }
                    )
                }
                
                if app.uid != nil {
                    Text("Preferences: ")
                        .foregroundColor(.white)
                        .font(.system(size:20))
                    
                    Card(
                        cornerRadius: 15,
                        elevation: 5,
                        height: 250,
                        color: CustomColor.backgroundCard,
                        views: {
                            AnyView(
                                
                                VStack{
                                    
                                    Toggle("Start Notfications:", isOn: $startNotifications)
                                        .padding(15)
                                        .foregroundColor(.white)
                                    Toggle("End Notfications:", isOn: $endNotifications)
                                        .padding(15)
                                        .foregroundColor(.white)
                                    Toggle("Enable Location Services:", isOn: $location)
                                        .padding(15)
                                        .foregroundColor(.white)
                                }
                                
                                
                            )
                        }
                    )
                    
                    Button(action: signOutFunc){
                        Text("LogOut")
                    }.buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle(radius: 10))
                        .tint(.red)
//                        .alert(isPresented: $createAlert){
//                            Alert(title: Text(alertText))
//                        }
                    
                    
                    
                    
                }
            }.padding(25) // end of VStack
            
        }.onAppear{
            startNotifications = app.user.startNotifications
            endNotifications = app.user.endNotifications
            location = app.user.locationServices
            
            // setUserData()
            // the Preview crashes but it runs fine in the simnulator
        }
        .onChange(of: startNotifications) { _ in
            app.user.startNotifications = startNotifications
            
//            db.collection("Users")
//                    .document(app.uid!)
//                    .setData(["startNotifications": startNotifications], merge: true) { error in
//                        print("Error uploading startNotifications to database: "
//                              + (error?.localizedDescription ?? "No localized description"))
//            }
            
            do {
                try db.collection("Users")
                    .document(app.uid!).setData(from:app.user)
                
                print("Start notifications updated")
            }
            catch {
                print("Error uploading event to database: \(error.localizedDescription)")
            }
        }
        .onChange(of: endNotifications) { _ in
            app.user.endNotifications = endNotifications
            
            do {
                try db.collection("Users")
                    .document(app.uid!).setData(from:app.user)
                
                print("End notifications updated")
            }
            catch {
                print("Error uploading event to database: \(error.localizedDescription)")
            }
        }
        .onChange(of: location) { _ in
            app.user.locationServices = location
            
            do {
                try db.collection("Users")
                    .document(app.uid!).setData(from:app.user)
                
                print("Locations updated")
            }
            catch {
                print("Error uploading event to database: \(error.localizedDescription)")
            }
        }
        
    }
    
//    private func setUserData(){
//
//        let userUID = Auth.auth().currentUser?.uid
//
//        db.collection("Users").document(userUID!).getDocument { (snapshot, error) in
//            if error != nil {
//                print("Error getting userDataString(describing: error)")
//            } else {
//                username = snapshot?.get("username") as! String
//                email = snapshot?.get("email") as! String
//                fullname = snapshot?.get("fullname") as! String
//            }
//        }
//    }
    
    /// This function signs a user out of their account through firebase
    
    func signOutFunc(){
        do {
            try Auth.auth().signOut()
            
            app.uid = nil
            app.eventList = []
            
            print ("User logged out.")
            
//            alertText = "User Logged Out"
//            createAlert = true
        } catch let signOutError as NSError{
            print("Error signing out: %@", signOutError)
        }
    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
            .environmentObject(AppVariables())
    }
}
