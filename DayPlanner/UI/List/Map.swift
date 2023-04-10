//
//  Map.swift
//  DayPlanner
//
//  Created by Orion Duffy on 4/9/23.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

//class Map: UIViewController {
//    let locationManager = CLLocationManager()
//    var currentLocation: CLLocation? = nil
//    var preciseZoom: Float = 15.0
//    var approximateZoom: Float = 10.0
//    var mapView: GMSMapView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.distanceFilter = 50
//        locationManager.startUpdatingLocation()
//        locationManager.delegate = self
//        
//        let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseZoom : approximateZoom
//        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: zoomLevel)
//        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
//    }
//
//}
//
//extension Map: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location: CLLocation = locations.last!
//        
//        let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseZoom : approximateZoom
//        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
//        
//        if mapView.isHidden {
//            mapView.isHidden = false
//            mapView.camera = camera
//        } else {
//            mapView.animate(to: camera)
//        }
//    }
//}
