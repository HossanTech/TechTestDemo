//
//  PeopleCardsRepository.swift
//  TechTestDemo
//
//  Created by MohammadHossan on 10/10/2024.
//

import Foundation

protocol PeopleCardsRepository {
  func getPeopleList(for url: URL) async throws -> PeopleData
}

struct PeopleRepositoryImplementation {
  private let networkManager: Fetchable
  
  init(networkManager: Fetchable) {
    self.networkManager = networkManager
  }
}

// MARK: - People Repository Implementation.

extension PeopleRepositoryImplementation: PeopleCardsRepository, JsonParser {
  
  // MARK: - Todo Get Todo List request form Network Layer.
  func getPeopleList(for url: URL) async throws -> PeopleData {
    do {
      let listsData = try await networkManager.get(url: url)
      return try parse(data: listsData, type: PeopleData.self)
    } catch {
      throw error
    }
  }
}


