//
//  ContentView.swift
//  LocationDemo
//
//  Created by Aybars Acar on 19/12/2021.
//

import SwiftUI
import MapKit


enum DisplayType {
  case list, map
}


struct ContentView: View {
  
  @StateObject private var viewModel: PlaceListViewModel = PlaceListViewModel()
  
  @State private var userTrackingMode: MapUserTrackingMode = .follow
  @State private var searchText: String = ""
  @State private var displayType: DisplayType = .map
  @State private var isDragged: Bool = false
  
  @FocusState private var isSearchBarFocused: Bool
  
  
  private func getRegion() -> Binding<MKCoordinateRegion> {
    
    guard let coordinate = viewModel.currentLocation else {
      return .constant(MKCoordinateRegion.defaultRegion)
    }
    
    return .constant(
      MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    )
  }
  
  
  var body: some View {
    
    VStack {
      
      TextField(
        "Search",
        text: $searchText,
        onEditingChanged: { _ in },
        onCommit: {
          // get all land marks
          viewModel.searchLandmarks(searchText)
        }
      )
        .focused($isSearchBarFocused)
        .padding(.vertical)
        .textFieldStyle(.roundedBorder)
      
      LandMarkCategoryView { selectedCategory in
        viewModel.searchLandmarks(selectedCategory)
      }
      .padding(.horizontal, 8)
      
      Picker(selection: $displayType, label: Text("Select")) {
        
        Text("Map").tag(DisplayType.map)
        Text("List").tag(DisplayType.list)
      }
      .pickerStyle(.segmented)
      
      switch displayType {
        
      case .list:
        LandMarkListView(landMarks: viewModel.landMarks)
        
      case .map:
        Map(
          coordinateRegion: getRegion(),
          interactionModes: .all,
          showsUserLocation: true,
          userTrackingMode: $userTrackingMode,
          annotationItems: viewModel.landMarks
        ) { LandMark in
          MapMarker(coordinate: LandMark.coordinate)
        }
        .gesture(
          DragGesture()
            .onChanged({ value in
              isDragged = true
            })
        )
        .overlay(
          isDragged ?
          AnyView(RecenterButton {
            viewModel.startUpdatingLocation()
            isDragged = false
          }.padding())
          : AnyView(EmptyView()),
          alignment: .bottom
        )
        
      }
      
      
    }
    .padding()
    
  }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
