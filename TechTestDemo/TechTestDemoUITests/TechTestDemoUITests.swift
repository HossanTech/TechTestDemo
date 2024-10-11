//
//  TechTestDemoUITests.swift
//  TechTestDemoUITests
//
//  Created by MohammadHossan on 10/10/2024.
//

import XCTest

final class TechTestDemoUITests: XCTestCase {
  
  override func setUpWithError() throws {
    continueAfterFailure = false
  }
  
  func testAppTitle() throws {
    
    let app = XCUIApplication()
    app.launch()
    let appTitle = app.navigationBars["People List"].staticTexts["People List"]
    XCTAssertTrue(appTitle.exists)
    appTitle.tap()
  }
}
