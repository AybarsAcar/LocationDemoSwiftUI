//
//  MKCoordinateRegionExtensions.swift
//  LocationDemo
//
//  Created by Aybars Acar on 19/12/2021.
//

import Foundation
import MapKit


extension MKCoordinateRegion {
  
  static var defaultRegion: MKCoordinateRegion {
    return MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: -37.8136, longitude: 144.9631),
      span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
  }
  
}
