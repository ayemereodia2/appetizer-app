//
//  AppertizerListView.swift
//  Appetizer
//
//  Created by ANDELA on 26/01/2025.
//

import SwiftUI

struct AppertizerListView: View {
  @StateObject var appertizerViewModel = AppertizerViewModel()
  @State private var isShowingDetail = false
  @State private var selectedAppertizer: Appertizer?
  
  var body: some View {
    ZStack {
      
      NavigationView {
        List(appertizerViewModel.appertizer){ appertizer in
          AppertizerCellView(model: appertizer)
            .onTapGesture {
              isShowingDetail.toggle()
              selectedAppertizer = appertizer
            }
        }
        .disabled(isShowingDetail)
        .overlay {
          if appertizerViewModel.appertizer.isEmpty {
            ProgressView()
              .progressViewStyle(.circular)
              .tint(Color(.brandPrimary))
          }
        }
        .navigationTitle("🍳 Appertizer")
      }
      .blur(radius: isShowingDetail ? 20 : 0)
      .onAppear {
        appertizerViewModel.getAppertizers()
      }
      .alert(item: $appertizerViewModel.alertItem) { item in
        Alert(title: item.title, message: item.message, dismissButton: item.dismissButton)
      }
      
      if isShowingDetail {
        AppertizerDetailView(appertizer:selectedAppertizer, isShowing: $isShowingDetail)
      }
      
    }
  }

}

#Preview {
    AppertizerListView()
}
