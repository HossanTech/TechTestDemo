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

  var body: some View {
    NavigationStack {
      VStack {
        switch viewModel.viewState {
        case.load(peoples: let peoples):
          List {
            ForEach(peoples, id: \.self) { peopleList in
              NavigationLink(destination: PeopleDetailsView(people: peopleList)) {
                PeopleCellView(people: peopleList)
              }
            }
          }
        case .refresh:
          progressView()
        case .error:
          alertView()
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          getToolBarView()
        }
      }
      .navigationTitle(Text("People List"))
    }
    .task {
      await getDataFromAPI()
    }
    .refreshable {
      await getDataFromAPI()
    }
  }
  
  // MARK: - Making API call call URL .
  func getDataFromAPI() async {
    await viewModel.getPeopleList(urlStr: Endpoint.peopleListURL)
  }
  
  // MARK: - Using ViewBuilder to create the child view.
  @ViewBuilder
  func progressView() -> some View {
    VStack{
      RoundedRectangle(cornerRadius: 15)
        .fill(.white)
        .frame(height: 180)
        .overlay {
          VStack{
            ProgressView().padding(50)
            Text("Please Wait Message").font(.headline)
          }
        }
    }
  }
  
  @ViewBuilder
  func alertView() -> some View {
    Text("").alert(isPresented: $viewModel.isError) {
      Alert(title: Text("General_Error"), message: Text(viewModel.customError?.localizedDescription ?? ""),dismissButton: .default(Text("Okay")))
    }
  }
  
  @ViewBuilder
  func getToolBarView() -> some View {
    Button {
      Task {
        await getDataFromAPI()
      }
    } label: {
      HStack {
        Image(systemName: "arrow.clockwise")
          .padding(.all, 10.0)
      }.fixedSize()
    }
    .cornerRadius(5.0)
  }
}

#Preview {
  PeopleListView(viewModel: PeopleListViewModel(repository: PeopleRepositoryImplementation(networkManager: NetworkManager())))
}
