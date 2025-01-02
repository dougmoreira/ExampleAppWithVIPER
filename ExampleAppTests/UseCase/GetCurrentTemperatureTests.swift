import XCTest

@testable import ExampleApp

final class GetCurrentTemperatureTests: XCTestCase {
    private lazy var sut = GetCurrentTemperature()
    
    func test_getTemperature_whenFailure() {
        
        sut.getTemperature { result in
            
        }
    }

}
