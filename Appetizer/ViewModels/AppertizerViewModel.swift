//
//  AppertizerViewModel.swift
//  Appetizer
//
//  Created by ANDELA on 27/01/2025.
//

import Foundation
class AppertizerViewModel: ObservableObject {
  @Published var appertizer:[Appertizer] = []
  @Published var alertItem:AlertItem?

  
  func getAppertizers() {
    let manager = NetworkManager(session: URLSession(configuration: .default))
    manager.getAppertizer { result in
      DispatchQueue.main.async {
        switch result {
        case .success(let appertizerObjects):
          self.appertizer = appertizerObjects
        case .failure(let error):
          switch error {
          case .invalidURL:
            self.alertItem = AlertContext.invalidURL
          case .invalidResponse:
            self.alertItem = AlertContext.invalidResponse
          case .invalidData:
            self.alertItem = AlertContext.invalidData
          case .unableToComplete:
            self.alertItem = AlertContext.unableToComplete
          }
        }
      }
    }
  }

}
