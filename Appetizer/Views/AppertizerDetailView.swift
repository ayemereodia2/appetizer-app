//
//  AppertizerDetailView.swift
//  Appetizer
//
//  Created by ANDELA on 28/01/2025.
//

import SwiftUI

struct AppertizerDetailView: View {
  let appertizer: Appertizer?
  @Binding var isShowing:Bool
  
    var body: some View {
      VStack {
        Image("asian-flank-steak")
          .resizable()
          .frame(maxWidth: .infinity, maxHeight: 300)
          .ignoresSafeArea(.all, edges: .top)
        VStack(spacing: 20) {
          Text(appertizer?.name ?? "")
            .font(.title2)
            .fontWeight(.semibold)
          
          Text(appertizer?.description ?? "")
            .multilineTextAlignment(.center)
            .font(.body)
            .padding()
          
          HStack(spacing: 40) {
            VStack {
              Text("Calories")
                .bold()
                .font(.caption)
              Text("\(appertizer?.calories ?? 99)")
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
                .italic()
            }
            VStack {
              Text("Carbs")
                .bold()
               .font(.caption)
              Text("\(appertizer?.carbs ?? 99)")
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
                .italic()
            }
            VStack {
              Text("Protein")
                .bold()
              .font(.caption)
              Text("\(appertizer?.protein ?? 99)")
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
                .italic()
            }
          }
          Spacer()
          PurchaseButton(price: appertizer?.price) {
            // purchase action
          }
        }
      }
      .overlay(alignment: .topTrailing) {
        FloatingCancelButton {
          isShowing.toggle()
        }
      }
      .frame(width: 320, height: 525)
      .background(Color(.systemBackground))
      .clipShape(.rect(cornerRadius: 12))
      .shadow(radius: 40)
    }
}

#Preview {
  AppertizerDetailView(
    appertizer: MockData.sampleAppetizer,
    isShowing: .constant(false) )
}

