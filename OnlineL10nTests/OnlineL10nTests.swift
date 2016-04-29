//
//  OnlineL18NTests.swift
//  OnlineL18NTests
//
//  Created by Sebastian Westemeyer on 26.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import XCTest
import ReactiveCocoa
@testable import OnlineL10n

class OnlineL18NTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLanguageUpdate() {
        let testObject = TestObject()

        // create new manager
        let manager = LocalizationManager(languageProvider: TestLanguageProvider(), defaultLanguage: "Deutschland", language: "Deutschland")

        XCTAssert(testObject.text == "", "String is not empty")

        testObject.subscribeToLanguage(self, manager: manager, key: "a")

        XCTAssert(testObject.text == "b", "String is not initialised")

        // select a language
        manager.selectLanguage("en")

        XCTAssert(testObject.text == "e", "String is not updated correctly")
    }
}
