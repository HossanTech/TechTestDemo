//
//  PeopleListView.swift
//  TechTestDemo
//
//  Created by MohammadHossan on 10/10/2024.
//

import SwiftUI

struct PeopleListView: View {
  // MARK: - Using State Object to make sure view model object will not destroyed or recreate.
  @StateObject var viewModel: PeopleListViewModel
  @State private var isErrorOccured = true
  @State private var searchText = ""
  
  var body: some View {
    NavigationStack {
      VStack {
        switch viewModel.viewState {
        case .loading:
          ProgressView()
        case .loaded:
          showPeopleListView()
        case .error:
          showErrorView()
        case .emptyView:
          EmptyView()
        }
      }
      .navigationTitle(Text(LocalizedStringKey("People List")))
      .searchable(text: $searchText, prompt: "Please enter the name..")
      .onChange(of: searchText, perform: viewModel.performSearch)
    }.task {
      await viewModel.getPeopleList(urlStr: Endpoint.peopleListURL)
    }
  }
  // MARK: - Using ViewBuilder to create the child view.
  @ViewBuilder
  func showPeopleListView() -> some View {
    List(viewModel.peopleList) { peopleList in
      NavigationLink {
        PeopleDetailsView(people: peopleList)
      }label: {
        PeopleCellView(people: peopleList)
      }
    }
  }
  
  @ViewBuilder
  func showErrorView() -> some View {
    ProgressView().alert(isPresented: $isErrorOccured) {
      Alert(title: Text("Error Occured"),message: Text("Something went wrong"),
            dismissButton: .default(Text("Ok")))
    }
  }
}

#Preview {
  PeopleListView(viewModel: PeopleListViewModel(repository: PeopleRepositoryImplementation(networkManager: NetworkManager())))
}
