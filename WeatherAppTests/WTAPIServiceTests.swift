//
//  WTAPIServiceTests.swift
//  WeatherAppTests
//
//  Created by Revanth Kumar Yarlagadda on 10/6/23.
//

import XCTest
@testable import WeatherApp

final class WTAPIServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testBaseURLIsSetupCorrect() {
        XCTAssertEqual(MockAPIURLBuilder().baseURL, "https://api.openweathermap.org/data/2.5/weather")
    }
    
    func testFailureWhenPassingEmptyCity() {
        let expectation  = XCTestExpectation(description: "Failure on passing empty city")
        let cityAPIService = WTCityAPIServiceImpl(urlBuilder: WTCityAPIURLBuilderImpl())
        cityAPIService.weather(for: "") { _ in
            
        } onFailure: { error in
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

}

class MockAPIURLBuilder: WTAPIURLBuilder {
    
}
