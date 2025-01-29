//
//  FloatingCancelButton.swift
//  Appetizer
//
//  Created by ANDELA on 28/01/2025.
//

import SwiftUI

struct FloatingCancelButton: View {
  var action: () -> Void
  
    var body: some View {
      Button {
        action()
      }label: {
        Image(systemName: "xmark.circle.fill")
          .resizable()
          .frame(width: 30, height: 30)
          .background(Color(.black))
          .foregroundStyle(Color(.white))
          .clipShape(.rect(cornerRadius: 15))
          .padding()
          
      }
    }
}

#Preview {
  FloatingCancelButton(){}
}
