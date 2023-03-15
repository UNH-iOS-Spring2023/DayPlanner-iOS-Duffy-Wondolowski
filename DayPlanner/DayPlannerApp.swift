//
//  DayPlannerApp.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }

}

@main
struct YourApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
        LandingView()
      }
    }
  }
}
