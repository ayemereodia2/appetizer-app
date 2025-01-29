//
//  PurchaseButton.swift
//  Appetizer
//
//  Created by ANDELA on 28/01/2025.
//

import SwiftUI

struct PurchaseButton: View {
  let price: Double?
  var action: () -> Void
  
    var body: some View {
      Button {
        action()
      }label: {
        Text("$\(price ?? 0.0, format: .currency(code: "US")) - Add To Order")
          .font(.title3)
          .frame(width: 280, height: 50)
          .fontWeight(.semibold)
          .foregroundStyle(Color(.white))
          .background(Color(.brandPrimary))    .clipShape(.rect(cornerRadius: 6))
      }
      .padding(.bottom, 20 )
    }
}

#Preview {
  PurchaseButton(price:99.0){}
}
