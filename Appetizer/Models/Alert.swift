//
//  Alert.swift
//  Appetizer
//
//  Created by ANDELA on 27/01/2025.
//

import SwiftUI

struct AlertItem: Identifiable {
  let id = UUID()
  let title:Text
  let message:Text
  let dismissButton: Alert.Button
}

struct AlertContext {
  
  static let invalidData = AlertItem(
    title: Text("Server error"),
    message: Text("The data received from the server is invalid. Please contact support"),
    dismissButton: .default(Text("Ok"))
  )
  
  static let invalidResponse = AlertItem(
    title: Text("Server errpr"),
    message: Text("Received invalid response from server. Please contact support."),
    dismissButton: .default(Text("Ok"))
  )
  
  static let invalidURL = AlertItem(
    title: Text("Server error"),
    message: Text("There was an issue connecting to the server. Please contact support"),
    dismissButton: .default(Text("Ok"))
  )
  
  static let unableToComplete = AlertItem(
    title: Text("Server error"),
    message: Text("Unable to complete request at this time. Please, check your internet connection"),
    dismissButton: .default(Text("Ok"))
  )
}
