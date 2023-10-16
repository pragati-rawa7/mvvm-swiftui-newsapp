//
//  NewsAppiOSUITests.swift
//  NewsAppiOSUITests
//
//  Created by Pragati RAWAT on 15/2/23.
//

import XCTest

class NewsListViewUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-news-networking-success":"1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_news_list_success(){
        app.launchEnvironment = ["-news-networking-success" : "1"]
        app.launch()
        
        let listview = app.tables["NEWS_LIST"]
        XCTAssertTrue(listview.exists)
        
        let navTitle  = app.navigationBars["Top Heading"]
        XCTAssertTrue(navTitle.staticTexts["Top Heading"].exists)
       
        XCTAssertTrue(listview.cells.count == 25)
        
        let cell = app.tables["NEWS_LIST"].cells.element(boundBy: 0)
        
        XCTAssertTrue(cell.exists)
        let source = cell.staticTexts["Yardbarker.com"]
        XCTAssertTrue(source.exists)
        let title = cell.staticTexts["Rangers bolster bullpen drastically with Aroldis Chapman trade"]
        XCTAssertTrue(title.exists)
        
        let description = cell.staticTexts["The Texas Rangers made a huge move to strengthen their bullpen, trading for Kansas City Royals reliever Aroldis Chapman."]
        XCTAssertTrue(description.exists)
    
    }
    
    func test_news_list_failure(){
        app.launchEnvironment = ["-news-networking-success" : "0"]
        app.launch()
        
        let errorView = app.staticTexts["errorView"]
        XCTAssertTrue(errorView.waitForExistence(timeout: 5))
        let errorMsg = app.staticTexts["Response data is invalid"]
        XCTAssertTrue(errorMsg.exists)
    }
}

