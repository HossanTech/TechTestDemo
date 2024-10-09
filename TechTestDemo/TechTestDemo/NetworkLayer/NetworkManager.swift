//
//  NetworkManager.swift
//  TechTestDemo
//
//  Created by MohammadHossan on 10/10/2024.
//

import Foundation

struct NetworkManager {
  
  private let urlSession: Networking
  init(urlSession: Networking = URLSession.shared) {
    self.urlSession = urlSession
  }
}

extension NetworkManager: Fetchable {
  
  // MARK: - Return People Url.
  func get(url: URL) async throws -> Data {
    do {
      let (data, response) = try await urlSession.data(form: url)
      // Validating response
      if  response.isValidResponse() {
        return data
      } else {
        throw NetworkError.dataNotFound
      }
    }
  }
}

extension URLResponse {
  
  func isValidResponse() -> Bool {
    guard let response = self as? HTTPURLResponse else {
      return false
    }
    switch response.statusCode {
    case 200...299:
      return true
    default:
      return false
    }
  }
}
