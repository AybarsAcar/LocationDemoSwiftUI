//
//  LocationManager.swift
//  LocationDemo
//
//  Created by Aybars Acar on 19/12/2021.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, ObservableObject {
  
  @Published var location: CLLocation? = nil
  
  private let _locationManager = CLLocationManager()
  
  override init() {
    super.init()
    _locationManager.delegate = self
    
    // set the location manager properties
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest
    _locationManager.distanceFilter = kCLDistanceFilterNone
    
    // request for user
    _locationManager.requestWhenInUseAuthorization()
    
    // keep tracking users location and give us the updated location
    _locationManager.startUpdatingLocation()
  }
  
  func startUpdates() {
    _locationManager.startUpdatingLocation()
  }
  
  func stopUpdates() {
    _locationManager.stopUpdatingLocation()
  }
}

extension LocationManager: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    guard let location = locations.last else { return }
    
    DispatchQueue.main.async {
      // update the published location in the LocationManager
      self.location = location
    }
  }
}
