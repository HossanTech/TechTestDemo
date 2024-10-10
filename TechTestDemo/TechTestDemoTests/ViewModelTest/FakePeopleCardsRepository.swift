//
//  FakePeopleCardsRepository.swift
//  TechTestDemoTests
//
//  Created by MohammadHossan on 10/10/2024.
//

import Foundation
@testable import TechTestDemo

class FakePeopleCardsRepository: PeopleCardsRepository {
  
  func getPeopleList(for url: URL) async throws -> TechTestDemo.People {
    do {
      let bundle = Bundle(for: FakeNetworkManager.self)
      guard let path =  bundle.url(forResource:url.absoluteString, withExtension: "json") else {
        throw NetworkError.invalidURL
      }
      let data = try Data(contentsOf: path)
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      let lists = try decoder.decode(People.self, from: data )
      return lists
    } catch {
      throw NetworkError.dataNotFound
    }
  }
}
