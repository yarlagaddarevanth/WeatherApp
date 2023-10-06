//
//  WTCityWeatherDataProviderTests.swift
//  WeatherAppTests
//
//  Created by Revanth Kumar Yarlagadda on 10/6/23.
//

import XCTest
@testable import WeatherApp

final class WTCityWeatherDataProviderTests: XCTestCase {

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

    func testDataProviderForSuccess() {
        let expectation = XCTestExpectation(description: "Successful API Call")
        
        // Simulating Success
        let mockAPIService = WTMockAPIServiceImpl(simulateSuccess: true, urlBuilder: WTMockCityAPIURLBuilder(), mockJsonFileName: "mockWeatherLondon")
        
        let sut = WTCityWeatherDataProviderImpl(apiService: mockAPIService)
        sut.weatherData(for: "") { weatherData in
            XCTAssertEqual(weatherData.cityName, "London")
            XCTAssertEqual(weatherData.weather?.main, "Clouds")
            XCTAssertEqual(weatherData.weather?.description, "overcast clouds")
            expectation.fulfill()
        } onFailure: { error in
            expectation.isInverted = true
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDataProviderForFailure() {
        let expectation = XCTestExpectation(description: "Failed API Call or parsing error")
        
        // Simulating failure
        let mockAPIService = WTMockAPIServiceImpl(simulateSuccess: false, urlBuilder: WTMockCityAPIURLBuilder(), mockJsonFileName: "mockWeatherLondon")
        
        let sut = WTCityWeatherDataProviderImpl(apiService: mockAPIService)
        sut.weatherData(for: "") { weatherData in
            expectation.isInverted = true
        } onFailure: { error in
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

}

//MARK: - Mock
class WTMockAPIServiceImpl: WTCityAPIService {
    var urlBuilder: WTCityAPIURLBuilder
    var successWeatherData = WTMockData.mockNewYorkSunnyWeatherData
    var failureError = WTError()
    var simulateSuccess: Bool
    var mockJsonFileName: String
    
    init(simulateSuccess: Bool, urlBuilder: WTCityAPIURLBuilder, mockJsonFileName: String) {
        self.simulateSuccess = simulateSuccess
        self.urlBuilder = urlBuilder
        self.mockJsonFileName = mockJsonFileName
    }
    
    func weather(for city: String, onSuccess: @escaping (WeatherApp.WTAPIResponse) -> Void, onFailure: @escaping (Error) -> Void) {
        if simulateSuccess {
            onSuccess(mockWeatherResponse(from: mockJsonFileName))
        } else {
            onFailure(failureError)
        }
    }
    
    private func mockWeatherResponse(from jsonFile: String) -> WTAPIResponse {
        let path = Bundle.main.path(forResource: jsonFile, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let response = try! decoder.decode(WTAPIResponse.self, from: data)
        return response
    }

}

class WTMockCityAPIURLBuilder: WTCityAPIURLBuilder {
    var cityUrlString: String = ""
}

