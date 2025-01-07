import XCTest

@testable import ExampleApp

final class GetCurrentTemperatureTests: XCTestCase {
    private let networkMock = URLSessionMock()
    private let urlString = "https://api.open-meteo.com/v1/forecast?latitude=-19.9208&longitude=-43.9378&hourly=temperature_2m&current_weather=true&forecast_days=1"
    
    private lazy var sut = GetCurrentTemperature(
        network: networkMock, urlString: urlString
    )
    
    func test_getTemperature_whenRequestIsSuccess_shouldCompletionWithCorrectResponse() {
        let temperature = 25.5
        let jsonString = """
        {
            "current_weather": {
                "temperature": \(temperature)
            }
        }
        """
        
        let validData = jsonString.data(using: .utf8)
        let url = URL(string: "example")
        let validResponse = HTTPURLResponse(
            url: url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        
        networkMock.data = validData
        networkMock.response = validResponse
        
        let expectation = self.expectation(description: "waiting for response test")
        
        sut.getTemperature { result in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success)
                XCTAssertEqual(success?.temperature, temperature)
            case .failure:
                XCTFail("should return success")
            }
            
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 1.0)
    }
    
    func test_getTemperature_whenFailureWithIncorrectStatusCode_shouldCompletionWithCorrecError() {
        let temperature: Double = 25.0
        let jsonString = """
        {
            "current_weather": {
                "temperature": \(temperature)
            }
        }
        """
        
        let data = jsonString.data(using: .utf8)
        
        networkMock.data = data
        networkMock.response = HTTPURLResponse(
            url: URL(string: "example")!,
            statusCode: 300,
            httpVersion: nil,
            headerFields: nil
        )
        
        sut.getTemperature { result in
            switch result {
            case .success:
                XCTFail("Should completion with incorrect status code error")
            case .failure(let failure):
                XCTAssertEqual(failure, ForecastError.invalidStatusCode)
            }
        }
    }
    
    func test_getTemperature_whenFailureWithInvalidDecodedData_shouldCompletionWithCorrectErrorType() {
        let temperature: Double = 25.0
        let jsonString = """
        {
            "current_weather": {
                "temperature_": \(temperature)
            }
        }
        """
        
        let invalidData = jsonString.data(using: .utf8)
        
        networkMock.data = invalidData
        networkMock.response = HTTPURLResponse(
            url: URL(string: "example")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        sut.getTemperature { result in
            switch result {
            case .success:
                XCTFail("should completion with invalid data error type")
            case .failure(let failure):
                XCTAssertEqual(failure, .invalidDecodedData)
            }
        }
    }
    
    func test_getTemperature_whenFailureWithInvalidData_shouldCompletionWithCorrectErrorType() {
        let temperature: Double = 25.0
        let jsonString = """
        {
            "current_weather": {
                "temperature": \(temperature)
            }
        }
        """
        
        let invalidData = jsonString.data(using: .symbol)
        
        networkMock.data = invalidData
        networkMock.response = HTTPURLResponse(
            url: URL(string: "example")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        sut.getTemperature { result in
            switch result {
            case .success:
                XCTFail("should completion with invalid data error type")
            case .failure(let failure):
                XCTAssertEqual(failure, .invalidData)
            }
        }
    }
    
    func test_getTemperature_withIncorrectURL_shouldCompletionWithCorrectErrorType() {
        let sut = GetCurrentTemperature(network: networkMock, urlString: nil)
        
        sut.getTemperature { result in
            switch result {
            case .success:
                XCTFail("should completion with invalid url error type")
            case .failure(let failure):
                XCTAssertEqual(failure, .invalidURL)
            }
        }
    }
}
