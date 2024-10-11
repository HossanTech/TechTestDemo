//
//  ViewSnapshottesting.swift
//  TechTestDemoTests
//
//  Created by MohammadHossan on 11/10/2024.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import TechTestDemo

final class ViewSnapshotTesting: XCTestCase {
  
  
  @MainActor func testPeopleListViewScreen() {
    let peopleListViewModel = PeopleListViewModel(repository: FakePeopleCardsRepository())
    let sut = PeopleListView(viewModel: peopleListViewModel)
    assertSnapshot(of: sut, as: .image)
  }
  
  @MainActor func testPeopleListViewScreenOnDrakeMode() {
    let peopleListViewModel = PeopleListViewModel(repository: FakePeopleCardsRepository())
    let PeopleListView = PeopleListView(viewModel: peopleListViewModel)
    let sut = UIHostingController(rootView: PeopleListView)
    let traitDarkMode = UITraitCollection(userInterfaceStyle: UIUserInterfaceStyle.dark)
    assertSnapshot(of: sut, as: .image(traits: traitDarkMode))

  }
  
  @MainActor func testPeopleListViewOniPhone13() throws {
    let peopleListViewModel = PeopleListViewModel(repository: FakePeopleCardsRepository())
    let PeopleListView = PeopleListView(viewModel: peopleListViewModel)
    let sut = UIHostingController(rootView: PeopleListView)
    assertSnapshot(of: sut, as: .image(on: .iPhone13))
  }
  
  @MainActor func testPeopleListViewOnLandscape() throws {
    let peopleListViewModel = PeopleListViewModel(repository: FakePeopleCardsRepository())
    let PeopleListView = PeopleListView(viewModel: peopleListViewModel)
    let sut = UIHostingController(rootView: PeopleListView)
    assertSnapshot(of: sut, as: .image(on: .iPhone13(.landscape)))
  }
  
  @MainActor func testPeopleListViewOnPortrait() throws {
    let peopleListViewModel = PeopleListViewModel(repository: FakePeopleCardsRepository())
    let PeopleListView = PeopleListView(viewModel: peopleListViewModel)
    let sut = UIHostingController(rootView: PeopleListView)
    assertSnapshot(of: sut, as: .image(on: .iPhone13(.portrait)))
  }
}
