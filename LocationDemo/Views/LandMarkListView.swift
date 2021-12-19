//
//  LandMarkListView.swift
//  LocationDemo
//
//  Created by Aybars Acar on 19/12/2021.
//

import SwiftUI


struct LandMarkListView: View {
  
  let landMarks: [LandMark]
  
  var body: some View {
    List(landMarks, id: \.id) { landMark in
      
      VStack(alignment: .leading, spacing: 10) {
        Text(landMark.name)
          .font(.headline)
        
        Text(landMark.title)
      }
      .padding(.vertical, 8)
    }
    .listStyle(.plain)
  }
}

