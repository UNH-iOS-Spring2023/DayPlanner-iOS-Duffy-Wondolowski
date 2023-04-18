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
import GoogleMaps
import GooglePlaces


class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        if let mapsApiKey = Bundle.main.infoDictionary?["MAPS_API_KEY"] as? String {
            GMSServices.provideAPIKey(mapsApiKey)
            GMSPlacesClient.provideAPIKey(mapsApiKey)
        } else {
            print("Day Planner: Error! Google Maps API key not found in info.plist!")
        }
        
        UNUserNotificationCenter.current().delegate = self

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
        SplashScreenView()
      }
    }
  }
}
