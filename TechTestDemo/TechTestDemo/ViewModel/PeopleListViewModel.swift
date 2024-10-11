//
//  PeopleListViewModel.swift
//  TechTestDemo
//
//  Created by MohammadHossan on 10/10/2024.
//

import Foundation

enum ViewState {
  case loading
  case error
  case loaded
  case emptyView
}

protocol PeopleListViewModelAction: ObservableObject {
  func getPeopleList(urlStr: String) async
}

// MARK: - People List ViewModel Implementation.
@MainActor
final class PeopleListViewModel {
  
  @Published private(set) var viewState: ViewState = .loaded
  @Published private(set) var filteredPeople = [PeopleData]()
  @Published private var peopleLists: [PeopleData] = []
  private let repository: PeopleCardsRepository
  
  init(repository: PeopleCardsRepository) {
    self.repository = repository
  }
  
  var peopleList: [PeopleData] {
    filteredPeople.isEmpty ? peopleLists: filteredPeople
  }
}

extension PeopleListViewModel: PeopleListViewModelAction {
  
  func getPeopleList(urlStr: String) async {
    viewState = .loaded
    guard let url = URL(string: urlStr) else { return }
    do {
      let lists = try await repository.getPeopleList(for: url)
      peopleLists = lists
      viewState =  peopleLists.isEmpty ? .emptyView : .loaded
    } catch {
      viewState = .error
    }
  }
}

// MARK: - Using debounce and delay 0.5 seconds to allow user to type into search bar and then start filtering the text.
extension PeopleListViewModel {
  func performSearch(keyword: String) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
      guard let self = self else { return }
      self.filteredPeople = self.peopleLists.filter {$0.firstName.localizedStandardContains(keyword)}
    }
  }
}
