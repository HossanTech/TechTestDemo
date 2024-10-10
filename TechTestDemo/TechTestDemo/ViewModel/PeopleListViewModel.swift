//
//  PeopleListViewModel.swift
//  TechTestDemo
//
//  Created by MohammadHossan on 10/10/2024.
//

import Foundation

enum ViewState {
  case load(peoples: [PeopleData])
  case refresh
  case error
}

protocol PeopleListViewModelAction: ObservableObject {
  func getPeopleList(urlStr: String) async
}

// MARK: - People List ViewModel Implementation.
@MainActor
final class PeopleListViewModel {
  
  @Published var viewState = ViewState.load(peoples: [])
  @Published var isError = false
  @Published var searchText = ""

  private(set)  var filteredPeople: [PeopleData] = []
  private(set) var peopleLists: [PeopleData] = []
  private(set) var customError: NetworkError?
  private let repository: PeopleCardsRepository
  
  init(repository: PeopleCardsRepository) {
    self.repository = repository
  }
}

extension PeopleListViewModel: PeopleListViewModelAction {
  func getPeopleList(urlStr: String) async {
    viewState = .refresh
    guard let url = URL(string: urlStr) else {
      self.customError = NetworkError.invalidURL
      return
    }
    do {
      let lists = try await repository.getPeopleList(for: url)
      peopleLists = lists
      viewState = .load(peoples: peopleLists)
    } catch {
      customError = error as? NetworkError
      isError = true
      viewState = .error
    }
  }
}

extension PeopleListViewModel {
  func performSearch(keyword: String) {
    filteredPeople = peopleLists.filter { $0.firstName.lowercased().contains(keyword)}
  }
  var peopleList: [PeopleData] {
    filteredPeople.isEmpty ? peopleLists: filteredPeople
  }
}
