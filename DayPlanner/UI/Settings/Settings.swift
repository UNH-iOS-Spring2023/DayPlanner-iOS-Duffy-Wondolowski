//
//  Settings.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct Settings: View {
    
    let db = Firestore.firestore()
    
    @State var username: String = "Username"
    @State var fullname: String = "Fullname"
    @State var email: String = "Email"
    
    @State private var endNotifications = false
    @State private var location = false
    @State private var startNotifications = false
    
    var body: some View {
        
        ZStack{
            CustomColor.background
                .ignoresSafeArea(.all)
            
            VStack (spacing: 20){
                
                Text("User Information: ")
                    .foregroundColor(.white)
                    .font(.system(size:20))
                
                Card(
                    cornerRadius: 15,
                    elevation: 5,
                    height: 125,
                    color: CustomColor.backgroundCard,
                    views: {
                        AnyView(
                            
                            HStack {
                                
                                VStack {
                                    Text(username)
                                        .foregroundColor(.white)
                                    Text(email)
                                        .foregroundColor(.white)
                                }
                                
                                Text(fullname)
                                    .foregroundColor(.white)
                                
                            }
                            
                        )
                        
                    }
                )
                
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
                
                Button(action: {}){
                    Text("LogOut")
                }.buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .tint(.red)
                
                
                
                
                
            }.padding(25) // end of VStack
            
        }.onAppear{
            setUserData()
            // the Preview crashes but it runs fine in the simnulator
        }
        
    }
    
    private func setUserData(){
        
        let userUID = Auth.auth().currentUser?.uid
        
        db.collection("Users").document(userUID!).getDocument { (snapshot, error) in
            if error != nil {
                print("Error getting userDataString(describing: error)")
            } else {
                username = snapshot?.get("username") as! String
                email = snapshot?.get("email") as! String
                fullname = snapshot?.get("fullname") as! String
            }
        }
    }
    
//    private func signOut(){
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//        } catch let signOutError as NSError{
//            print("Error signing out: %@", signOutError)
//        }
//    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
