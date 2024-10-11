//
//  PeopleListViewModelTest.swift
//  TechTestDemoTests
//
//  Created by MohammadHossan on 10/10/2024.
//

import XCTest
@testable import TechTestDemo

final class PeopleListViewModelTest: XCTestCase {
  
  var fakePeopleCardsRepository: FakePeopleCardsRepository?
  var peopleListViewModel: PeopleListViewModel?
  
  @MainActor override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    fakePeopleCardsRepository = FakePeopleCardsRepository()
    peopleListViewModel = PeopleListViewModel(repository: fakePeopleCardsRepository ?? FakePeopleCardsRepository())
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    fakePeopleCardsRepository = nil
    peopleListViewModel = nil
  }
  
  // when url is correct, should have some data in People List
  func test_getPeopleList_When_URL_Is_Correct() async {
    
    // GIVEN
    await peopleListViewModel?.getPeopleList(urlStr: "PeopleCardsResponse")
    
    // WHEN
    let peopleList =  await peopleListViewModel?.peopleList
    guard let peopleList = peopleList else {
      XCTFail("List is nil")
      return
    }
    
    // THEN
    // checking records count and people note on success
    XCTAssertNotNil(peopleList)
    XCTAssertEqual(peopleList.count, 94)
    XCTAssertEqual(peopleList.first?.firstName, "Maggie")
    XCTAssertEqual(peopleList.first?.id, "1")
  }
  
  // When Api fails , it will throw dataNotFound error
  func testGetPeopleList_When_APIFailure() async {
    
    // GIVEN
    XCTAssertNotNil(peopleListViewModel)
    await peopleListViewModel?.getPeopleList(urlStr: "EmployeeCardsEmptyResponse")
    
    // WHEN
    let peopleList = await peopleListViewModel?.peopleList
    guard let peopleList = peopleList else {
      XCTFail("List is nil")
      return
    }
    // THEN
    // number of records will be zero
    XCTAssertEqual(peopleList.count, 0)
    XCTAssertNil(peopleList.first?.firstName)
    XCTAssertNil(peopleList.first?.lastName)
  }
  
  // when url is not empty but incorrect format
  func testGetPeopleList_When_URL_is_Incorrect() async {
    
    // GIVEN
    XCTAssertNotNil(peopleListViewModel)
    await peopleListViewModel?.getPeopleList(urlStr: "EmployeeCardsResponseWrongURL")
    
    // WHEN
    let peopleList = await peopleListViewModel?.peopleList
    guard let peopleList = peopleList else {
      XCTFail("List is nil")
      return
    }
    // THEN
    // Empty records
    XCTAssertEqual(peopleList.count, 0)
    XCTAssertNil(peopleList.first?.firstName)
    XCTAssertNil(peopleList.first?.id)
  }
  
  // when url is correct, should have some data in People List
  func test_Search_When_URL_Is_Correct() async {
    
    // GIVEN
    await peopleListViewModel?.getPeopleList(urlStr: "PeopleCardsResponse")
    
    // WHEN
    let peopleList =  await peopleListViewModel?.peopleList
    guard let peopleList = peopleList else {
      XCTFail("List is nil")
      return
    }
    await peopleListViewModel?.performSearch(keyword: "Rock")
    // THEN
    // checking records count and people note on success
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      XCTAssertNotNil(peopleList)
      XCTAssertEqual(peopleList.count, 1)
      XCTAssertEqual(peopleList.first?.firstName, "Rocky")
      XCTAssertEqual(peopleList.first?.id, "6")
    }
  }
  
  func test_Search_When_Text_Is_Magg() async {
    
    // GIVEN
    await peopleListViewModel?.getPeopleList(urlStr: "PeopleCardsResponse")
    
    // WHEN
    let peopleList =  await peopleListViewModel?.peopleList
    guard let peopleList = peopleList else {
      XCTFail("List is nil")
      return
    }
    await peopleListViewModel?.performSearch(keyword: "Magg")
    // THEN
    // checking records count and people note on success
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      XCTAssertNotNil(peopleList)
      XCTAssertEqual(peopleList.count, 7)
      XCTAssertEqual(peopleList.first?.firstName, "Maggi")
    }
  }
}

