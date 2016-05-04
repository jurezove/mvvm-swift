//
//  MVVMUITests.swift
//  MVVMUITests
//
//  Created by Jure Zove on 01/05/16.
//  Copyright © 2016 Jure Zove. All rights reserved.
//

import XCTest

class MVVMUITests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testFerrariF12DataDisplayed() {
    let app = XCUIApplication()
    let table = app.tables.elementBoundByIndex(0)
    
    let ferrariCell = table.cells.elementBoundByIndex(0)
    XCTAssert(ferrariCell.staticTexts["Ferrari F12"].exists)
    XCTAssert(ferrariCell.staticTexts["730 HP"].exists)
    
    let zondaCell = table.cells.elementBoundByIndex(1)
    XCTAssert(zondaCell.staticTexts["Pagani Zonda F"].exists)
    XCTAssert(zondaCell.staticTexts["602 HP"].exists)
    
    let lamboCell = table.cells.elementBoundByIndex(2)
    XCTAssert(lamboCell.staticTexts["Lamborghini Aventador"].exists)
    XCTAssert(lamboCell.staticTexts["700 HP"].exists)
  }
  
  func testCarDetailViewReflectsChangesInTableView() {
    let app = XCUIApplication()
    let table = app.tables.elementBoundByIndex(0)
    
    let ferrariCell = table.cells.elementBoundByIndex(0)
    ferrariCell.tap()
    
    XCTAssert(app.navigationBars.staticTexts["Ferrari F12"].exists)
    XCTAssert(app.textFields["Ferrari"].exists)
    XCTAssert(app.textFields["F12"].exists)
    XCTAssert(app.textFields["544"].exists) // Kilowatts
    
    // Now let's change the car and see if changes are reflected in the VC title
    
    app.textFields["Model"].clearAndEnterText("Enzo")
    app.textFields["Kilowatts"].clearAndEnterText("485")
    
    XCTAssert(app.navigationBars.staticTexts["Ferrari Enzo"].exists)
    
    // Let's see if changes are also reflected in the table view on the home screen
    app.navigationBars.buttons.elementBoundByIndex(0).tap()
    
    XCTAssert(ferrariCell.staticTexts["Ferrari Enzo"].exists)
    XCTAssert(ferrariCell.staticTexts["650 HP"].exists)
  }
  
}

extension XCUIElement {
  /*
   Source: http://stackoverflow.com/a/32894080/445613
   Removes any current text in the field before typing in the new value
   - Parameter text: the text to enter into the field
   */
  
  func clearAndEnterText(text: String) -> Void {
    guard let stringValue = self.value as? String else {
      XCTFail("Tried to clear and enter text into a non string value")
      return
    }
    
    self.tap()
    
    var deleteString: String = ""
    for _ in stringValue.characters {
      deleteString += "\u{8}"
    }
    self.typeText(deleteString)
    
    self.typeText(text)
  }
}
