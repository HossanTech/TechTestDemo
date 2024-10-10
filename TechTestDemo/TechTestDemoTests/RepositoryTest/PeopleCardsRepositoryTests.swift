//
//  PeopleCardsRepositoryTests.swift
//  TechTestDemoTests
//
//  Created by MohammadHossan on 10/10/2024.
//

import XCTest
@testable import TechTestDemo

final class PeopleCardsRepositoryTests: XCTestCase {
  
  var fakeNetworkManager: FakeNetworkManager?
  var peopleCardsRepository: PeopleCardsRepository?
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    fakeNetworkManager = FakeNetworkManager()
    peopleCardsRepository = PeopleRepositoryImplementation (networkManager: fakeNetworkManager ?? FakeNetworkManager())
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    peopleCardsRepository = nil
    
  }
  
  // when passes People list array will return with some data
  func test_Get_People_List_In_Success_Case() async {
    
    // GIVEN
    guard let url = URL(string: "PeopleCardsResponse") else {
      XCTFail("URL not found")
      return
    }
    
    let lists = try? await peopleCardsRepository?.getPeopleList(for: url)
    // WHEN
    guard let listItem = lists else {
      XCTFail("List is nil")
      return
    }
    
    //THEN
    XCTAssertNotNil(listItem)
    XCTAssertTrue(listItem.count > 0)
    XCTAssertEqual(listItem.count, 94)
    XCTAssertEqual(listItem.first?.firstName, "Maggie")
  }
  
  // When  People list is empty.
  func test_Get_People_List_In_Failure_Case() async {
    
    // GIVEN
    guard let url = URL(string: "EmployeeCardsEmptyResponse") else {
      XCTFail("URL not found")
      return
    }
    
    let lists = try? await peopleCardsRepository?.getPeopleList(for: url)
    
    //THEN
    XCTAssertNil(lists)
    XCTAssertNil(lists?.first?.firstName)
    XCTAssertNil(lists?.first?.avatar)
    XCTAssertNil(lists?.first?.id)
  }
}
