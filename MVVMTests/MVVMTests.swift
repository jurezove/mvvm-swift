//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by Jure Zove on 01/05/16.
//  Copyright © 2016 Jure Zove. All rights reserved.
//

import XCTest
@testable import MVVM

class MVVMTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testCarViewModelWithFerrariF12() {
    let ferrariF12 = Car(model: "F12", make: "Ferrari", kilowatts: 544, photoURL: "http://auto.ferrari.com/en_EN/wp-content/uploads/sites/5/2013/07/Ferrari-F12berlinetta.jpg")
    let ferrariViewModel = CarViewModel(car: ferrariF12)
    XCTAssertEqual(ferrariViewModel.modelText, "F12")
    XCTAssertEqual(ferrariViewModel.makeText, "Ferrari")
    XCTAssertEqual(ferrariViewModel.horsepowerText, "730 HP")
    XCTAssertEqual(ferrariViewModel.photoURL, NSURL(string: ferrariF12.photoURL))
    XCTAssertEqual(ferrariViewModel.titleText, "Ferrari F12")
  }
  
}
