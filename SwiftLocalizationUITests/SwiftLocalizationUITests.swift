//
//  SwiftLocalizationUITests.swift
//  SwiftLocalizationUITests
//
//  Created by Sebastian Westemeyer on 27.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import XCTest
import OnlineL10n

class SwiftLocalizationUITests: XCTestCase {

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

    func testUILocalization() {
        let app = XCUIApplication()
        app.segmentedControls.buttons["Englisch"].tap()
        XCTAssert(app.textFields["text_field"].value as? String == "a beautiful text field", "Text does not match!")
        XCTAssert(app.textViews["text_view"].value as? String == "a multi-line text view which is\nnot\nentirely\nfilled.", "Text does not match!")

        app.segmentedControls.buttons["German"].tap()
        XCTAssert(app.textFields["text_field"].value as? String == "Ein tolles Eingabefeld", "Text does not match!")
        XCTAssert(app.textViews["text_view"].value as? String == "Eine mehrzeilige Text-Ansicht nicht\nbesonders\ndoll befüllt.", "Text does not match!")

        app.buttons["button"].tap()

        app.tables.staticTexts["en"].tap()
        app.navigationBars["Select country"].buttons["Done"].tap()

        XCTAssert(app.textFields["text_field"].value as? String == "a beautiful text field", "Text does not match!")
        XCTAssert(app.textViews["text_view"].value as? String == "a multi-line text view which is\nnot\nentirely\nfilled.", "Text does not match!")
        app.segmentedControls.buttons["Englisch"].tap()
    }
}
