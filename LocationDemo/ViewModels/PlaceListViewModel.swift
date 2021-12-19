//
//  PlaceListViewModel.swift
//  LocationDemo
//
//  Created by Aybars Acar on 19/12/2021.
//

import Foundation
import Combine
import CoreLocation
import MapKit


class PlaceListViewModel: ObservableObject {
  
  @Published var currentLocation: CLLocationCoordinate2D?
  @Published var landMarks: [LandMark] = []
  
  private let _locationManager: LocationManager
  var cancellable: AnyCancellable?
  
  init() {
    _locationManager = LocationManager()
    
    // subscribe to the location to track the changes
    cancellable = _locationManager.$location.sink { location in
      
      // unwrap location
      if let location = location {
        DispatchQueue.main.async {
          self.currentLocation = location.coordinate
          
          // stop updates as we are moving around the map - choice which can be removed
          self._locationManager.stopUpdates()
        }
      }
    }
  }
  
  
  func startUpdatingLocation() {
    _locationManager.startUpdates()
  }
  
  
  func searchLandmarks(_ searchTerm: String) {
    
    let request = MKLocalSearch.Request()
    
    request.naturalLanguageQuery = searchTerm
    
    let search = MKLocalSearch(request: request)
    
    search.start { response, error in
      
      if let error = error {
        print(error)
        
      } else if let response = response {
        
        let mapItems = response.mapItems
        
        // populate the landmarks
        self.landMarks = mapItems.map { mapItem in
          return LandMark(placemark: mapItem.placemark)
        }
      }
    }
  }
}
