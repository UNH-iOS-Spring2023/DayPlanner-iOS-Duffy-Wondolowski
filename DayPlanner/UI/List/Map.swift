//
//  Map.swift
//  DayPlanner
//
//  Created by Orion Duffy on 4/9/23.
//

import SwiftUI
import GoogleMaps

struct Map: View {
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation? = nil
    
    init() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        Map()
    }
}
