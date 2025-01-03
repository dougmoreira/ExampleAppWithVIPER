import XCTest
@testable import ExampleApp

final class ForecastInteractorTests: XCTestCase {
    private let presenterSpy = ForecastPresenterSpy()
    private let getCurrentTemperatureSpy = GetCurrentTemperatureSpy()
    private lazy var sut = ForecastInteractor(
        presenter: presenterSpy, 
        getCurrentTemperature: getCurrentTemperatureSpy
    )
    
    func test_fetchCurrentTemperature_whenCompletionIsSuccess_shouldCallPresenterWithCorrectData() {
        let temperature: Double = 27
        
        getCurrentTemperatureSpy.completionToBeReturned = .success(.init(temperature: temperature))
        sut.fetchCurrentTemperature(request: .init())
        
        XCTAssertEqual(presenterSpy.presentCurrentForecastCallCount, 1)
        XCTAssertEqual(presenterSpy.presentCurrentForecastResponsePassed?.temperature, temperature)
    }

}
