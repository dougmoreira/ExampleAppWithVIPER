//
//  ForecastInteractorTests.swift
//  ExampleAppTests
//
//  Created by Douglas Moreira on 30/12/24.
//

import XCTest
@testable import ExampleApp

final class ForecastInteractorTests: XCTestCase {
    private let presenterSpy = ForecastPresenterSpy()
    private lazy var sut = ForecastInteractor(
        presenter: presenterSpy
    )
    
    func test_didLoad() {
        sut.didLoad(request: .init())
        
        XCTAssertEqual(presenterSpy.presentCurrentForecastCallCount, 1)
    }

}
