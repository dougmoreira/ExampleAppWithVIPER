import XCTest

@testable import ExampleApp

final class GetCurrentTemperatureTests: XCTestCase {
    let networkMock = URLSessionMock()
    private lazy var sut = GetCurrentTemperature(
        network: networkMock
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
    

}
