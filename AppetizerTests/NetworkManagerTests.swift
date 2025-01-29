//
//  NetworkManagerTests.swift
//  AppetizerTests
//
//  Created by ANDELA on 27/01/2025.
//

import XCTest
@testable import Appetizer

final class NetworkManagerTests: XCTestCase {
  
  func testAppertizerGetResponse() {
    // Arrange
    let mockSession = MockNetworkSession()
    let mockResponse = HTTPURLResponse(url: URL(string: NetworkManager.appertizerPath)!,
                                       statusCode: 404,
                                       httpVersion: nil,
                                       headerFields: nil)
    mockSession.response = mockResponse
    mockSession.data = """
            {
                "request": [
                    { "id": 1, "name": "Test Appetizer","description": "This is the description for my appetizer. It's yummy.", "price": 9.99, "imageURL": "https.example.com", "calories":45, "protein": 99, "carbs": 99 }
                    
                  ]
            }
            """.data(using: .utf8)
    
    let service = NetworkManager(session: mockSession)
    let expectation = self.expectation(description: "Completion handler called")
    
    // Act
    service.getAppertizer { result in
      // Assert
      switch result {
      case .success(let appetizers):
        XCTAssertEqual(appetizers.count, 1)
        XCTAssertEqual(appetizers[0].name, "Test Appetizer")
      case .failure(let error):
        XCTAssertEqual(APError.unableToComplete, error)
      }
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 1.0)
    
    
  }
  
  
  func testGetAppetizerInvalidResponse() {
    // Arrange
    let mockSession = MockNetworkSession()
    mockSession.response = HTTPURLResponse(url: URL(string: NetworkManager.appertizerPath)!,
                                           statusCode: 500,
                                           httpVersion: nil,
                                           headerFields: nil)
    let service = NetworkManager(session: mockSession)
    let expectation = self.expectation(description: "Completion handler called")
    
    // Act
    service.getAppertizer { result in
      // Assert
      switch result {
      case .success:
        XCTFail("Expected failure, got success")
      case .failure(let error):
        XCTAssertEqual(error, .invalidResponse)
      }
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 1.0)
  }
  
}

class MockNetworkSession: NetworkSession {
  var data: Data?
  var error: Error?
  var response: URLResponse?
  
  func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    return MockURLSessionDataTask {
      completionHandler(self.data, self.response, self.error)
    }
  }
}

class MockURLSessionDataTask: URLSessionDataTask {
  private let closure: () -> Void
  
  init(closure: @escaping () -> Void) {
    self.closure = closure
  }
  
  override func resume() {
    closure()
  }
}
