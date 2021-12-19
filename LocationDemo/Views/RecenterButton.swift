//
//  RecenterButton.swift
//  LocationDemo
//
//  Created by Aybars Acar on 19/12/2021.
//

import SwiftUI


struct RecenterButton: View {
  
  let onTapped: () -> Void
  
  var body: some View {
    Button {
      onTapped()
    } label: {
      Label("Re-center", systemImage: "triangle")
    }
    .padding(10)
    .foregroundColor(.white)
    .background(Color.accentColor)
    .clipShape(RoundedRectangle(cornerRadius: 12))

  }
}



struct RecenterButton_Previews: PreviewProvider {
  static var previews: some View {
    RecenterButton { }
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
