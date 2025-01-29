//
//  AppertizerCellView.swift
//  Appetizer
//
//  Created by ANDELA on 27/01/2025.
//

import SwiftUI

struct AppertizerCellView: View {
  let model: Appertizer
    var body: some View {
      HStack(alignment: .center) {
        /*
         AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/2/28/JPG_Test.jpg"))
           //.resizable()
           .aspectRatio(contentMode: .fit)
           .frame(width: 120, height: 90)
           .clipShape(RoundedRectangle(cornerRadius: 10))
         */
        Image("asian-flank-steak")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 120, height: 90)
        .clipShape(.rect(cornerRadius: 8))
        
        VStack(alignment:.leading, spacing: 5) {
          Text(model.name)
            .font(.title2)
            .fontWeight(.medium)
          Text("\(model.price, specifier: "%.2f")")
            .foregroundStyle(.secondary)
            .fontWeight(.semibold)
        }
        .padding(.leading)
        
      }
    }
}

#Preview {
  AppertizerCellView(model: MockData.sampleAppetizer)
}
