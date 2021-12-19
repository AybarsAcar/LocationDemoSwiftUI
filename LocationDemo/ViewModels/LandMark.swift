//
//  Landmark.swift
//  LocationDemo
//
//  Created by Aybars Acar on 19/12/2021.
//

import Foundation
import MapKit


struct LandMark: Identifiable {
  let id: UUID = UUID()
  
  let placemark: MKPlacemark
  
  var name: String {
    placemark.name ?? ""
  }
  
  var title: String {
    placemark.title ?? ""
  }
  
  var coordinate: CLLocationCoordinate2D {
    placemark.coordinate
  }
}
