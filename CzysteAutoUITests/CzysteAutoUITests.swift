//
//  CzysteAutoUITests.swift
//  CzysteAutoUITests
//
//  Created by Adrian Derdaś on 13/09/2023.
//

import XCTest

final class CzysteAutoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        
        let tablesQuery = app.tables
        
        
        let mycieSilnikaCellsQuery = tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Mycie silnika")/*[[".cells.containing(.staticText, identifier:\"149 PLN\")",".cells.containing(.staticText, identifier:\"Mycie silnika\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mycieSilnikaCellsQuery.buttons["shopping cart"].tap()
        
        let mycieStandardoweCellsQuery = tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Mycie standardowe")/*[[".cells.containing(.staticText, identifier:\"99 PLN\")",".cells.containing(.staticText, identifier:\"Mycie standardowe\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mycieStandardoweCellsQuery.buttons["shopping cart"].tap()
        
        let myciePodlogiCellsQuery = tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Mycie podlogi")/*[[".cells.containing(.staticText, identifier:\"79 PLN\")",".cells.containing(.staticText, identifier:\"Mycie podlogi\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        myciePodlogiCellsQuery.buttons["shopping cart"].tap()
        
        app.tabBars["Tab Bar"].buttons["Koszyk"].tap()
        
        mycieSilnikaCellsQuery.children(matching: .other).element(boundBy: 1).tap()
        
        mycieStandardoweCellsQuery.children(matching: .other).element(boundBy: 0).tap()
        
        let element = myciePodlogiCellsQuery.children(matching: .other).element(boundBy: 0)
        element.tap()
        element.tap()
                  

        
                // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
