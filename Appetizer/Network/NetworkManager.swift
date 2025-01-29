//
//  NetworkManager.swift
//  Appetizer
//
//  Created by ANDELA on 27/01/2025.
//

import Foundation

protocol NetworkSession {
  func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

final class NetworkManager {
  private let session: NetworkSession
  
  init(session: NetworkSession) {
    self.session = session
  }
  
  static let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals"
  private(set) static var appertizerPath = baseURL + "/appertizers"
  
  
  func getAppertizer(completed: @escaping (Result<[Appertizer], APError>) -> Void) {
    
    guard let url = URL(string: NetworkManager.appertizerPath) else {
      completed(.failure(.invalidURL))
      return
    }
    let urlRequest = URLRequest(url: url)
    
    session.dataTask(with: urlRequest) { data, response, error in
      if let _ = error  {
        completed(.failure(.unableToComplete))
        return
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 404 else {
        completed(.failure(.invalidResponse))
        return
      }
      
      guard var data = data else {
        completed(.failure(.invalidData))
        return
      }
      data = """
              {
                "request": [
                  {
                    "id": 1,
                    "name": "Buffalo Wings",
                    "description": "Spicy and tangy buffalo wings served with ranch dip.",
                    "price": 12.99,
                    "imageURL": "https://images.unsplash.com/photo-1601066524319-06eab0f1e34e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400",
                    "calories": 90,
                    "protein": 45,
                    "carbs": 12
                  },
                  {
                    "id": 2,
                    "name": "Cheese Nachos",
                    "description": "Crispy nachos topped with melted cheese and jalapeños.",
                    "price": 8.49,
                    "imageURL": "https://images.unsplash.com/photo-1617196035346-c548e222ba8e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400",
                    "calories": 25,
                    "protein": 15,
                    "carbs": 40
                  },
                  {
                    "id": 3,
                    "name": "Veggie Spring Rolls",
                    "description": "Crispy spring rolls filled with fresh vegetables and served with sweet chili sauce.",
                    "price": 6.99,
                    "imageURL": "https://images.unsplash.com/photo-1625938140038-2b95aafdbdbb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400",
                      "calories": 95,
                    "protein": 10,
                    "carbs": 25
                  },
                  {
                    "id": 4,
                    "name": "Loaded Potato Skins",
                    "description": "Potato skins loaded with cheese, bacon, and sour cream.",
                    "price": 10.99,
                    "imageURL": "https://images.unsplash.com/photo-1616362340058-3cc0d18075c6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400",
                    "calories": 15,
                    "protein": 25,
                    "carbs": 35
                  },
                  {
                    "id": 5,
                    "name": "Garlic Breadsticks",
                    "description": "Warm and soft breadsticks brushed with garlic butter.",
                    "price": 5.99,
                    "imageURL": "https://images.unsplash.com/photo-1623257456575-0ed8aab2c0a2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400",
                    "calories": 45,
                    "protein": 8,
                    "carbs": 30
                  },
                  {
                    "id": 6,
                    "name": "Ginger Breadsticks",
                    "description": "Warm and soft breadsticks brushed with garlic butter.",
                    "price": 5.99,
                    "imageURL": "https://images.unsplash.com/photo-1623257456575-0ed8aab2c0a2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400",
                    "calories": 45,
                    "protein": 8,
                    "carbs": 30
                  },
                  {
                    "id": 7,
                    "name": "Ogbolor Soup",
                    "description": "Warm and soft breadsticks brushed with garlic butter.",
                    "price": 5.99,
                    "imageURL": "https://images.unsplash.com/photo-1623257456575-0ed8aab2c0a2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400",
                    "calories": 45,
                    "protein": 8,
                    "carbs": 30
                  }
                ]
              }

            """.data(using: .utf8)!
      
      do {
        let result = try JSONDecoder().decode(AppetizerResponse.self, from: data)
        completed(.success(result.request))
        return
      }catch(let error) {
        print(error)
        completed(.failure(.invalidData))
        return
      }
      
    }.resume()
    
  }
}

extension URLSession: NetworkSession {}
