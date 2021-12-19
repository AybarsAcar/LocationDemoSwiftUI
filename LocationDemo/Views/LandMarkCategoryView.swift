//
//  LandMarkCategoryVie.swift
//  LocationDemo
//
//  Created by Aybars Acar on 19/12/2021.
//

import SwiftUI

struct Constants {
  static let categories = [
    "Groceries",
    "Hotels",
    "Coffee",
    "Gas",
    "Takeout",
    "Pharmacies"
  ]
}


struct LandMarkCategoryView: View {
  
  let onSelectedCategory: (String) -> Void
  
  @State private var selectedCategory = ""
  
  var body: some View {
    
    ScrollView(.horizontal, showsIndicators: false) {
      
      HStack {
        ForEach(Constants.categories, id: \.self) { category in
          Button(action: {
            selectedCategory = category
            onSelectedCategory(category)
          }, label: {
            Text(category)
              .padding(.vertical, 6)
              .padding(.horizontal)
          })
            .foregroundColor(selectedCategory == category ? Color.primary : Color.secondary)
            .background(selectedCategory == category ? Color.secondary : Color.white.opacity(0))
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        }
      }
    }
  }
}



struct LandMarkCategoryVie_Previews: PreviewProvider {
  static var previews: some View {
    LandMarkCategoryView(onSelectedCategory: { _ in })
      .previewLayout(.sizeThatFits)
  }
}
