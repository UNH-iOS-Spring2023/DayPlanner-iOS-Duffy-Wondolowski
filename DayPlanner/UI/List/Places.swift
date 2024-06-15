//
//  Places.swift
//  DayPlanner
//
//  Created by Orion Duffy on 4/10/23.
//

import SwiftUI
import GooglePlaces

struct Places: UIViewControllerRepresentable {
    var location: Binding<String>
    var placeSearch: Binding<Bool>
    
    init(location: Binding<String>, placeSearch: Binding<Bool>) {
        self.location = location
        self.placeSearch = placeSearch
    }
    
    func makeUIViewController(context: Context) -> PlaceSearch {
        return PlaceSearch(location: location, placeSearch: placeSearch)
    }
    
    func updateUIViewController(_ uiViewController: PlaceSearch, context: Context) {
        
    }
    
    typealias UIViewControllerType = PlaceSearch
    
    
}

//Mostly copied from Google's documentation
class PlaceSearch: UIViewController {
    var location: Binding<String>
    var placeSearch: Binding<Bool>
    
    init(location: Binding<String>, placeSearch: Binding<Bool>) {
        self.location = location
        self.placeSearch = placeSearch
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchAutocomplete()
    }
    
    // Present the Autocomplete view controller when the button is pressed.
    func launchAutocomplete() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt64(GMSPlaceField.name.rawValue) |
                                                  UInt64(GMSPlaceField.placeID.rawValue))
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
}

extension PlaceSearch: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        location.wrappedValue = place.name ?? ""
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Day Planner Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
