//
//  TechTestDemoApp.swift
//  TechTestDemo
//
//  Created by MohammadHossan on 10/10/2024.
//

import SwiftUI

@main
struct TechTestDemoApp: App {
  
  // MARK: - Creating People List View with view model Repository and NetworkManager .
  
  var body: some Scene {
    WindowGroup {
      PeopleListView(viewModel: PeopleListViewModel(repository: PeopleRepositoryImplementation(networkManager: NetworkManager())))
    }
  }
}
