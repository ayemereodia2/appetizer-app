//
//  ContentView.swift
//  Appetizer
//
//  Created by ANDELA on 26/01/2025.
//

import SwiftUI

struct AppetizerTabView: View {
    var body: some View {
      TabView {
        
        Tab("Home", systemImage: "house") {
          AppertizerListView()
        }
        
        Tab("Account", systemImage: "person") {
          AccountView()
        }
        
        Tab("Order", systemImage: "bag") {
          OrderView()
        }
      
      }
      .tint(Color(.brandPrimary))
    }
}

#Preview {
    AppetizerTabView()
}
