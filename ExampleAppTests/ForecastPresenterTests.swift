//
//  ForecastPresenterTests.swift
//  ExampleAppTests
//
//  Created by Douglas Moreira on 02/01/25.
//

import XCTest
@testable import ExampleApp

final class ForecastPresenterTests: XCTestCase {
    private let viewControllerSpy = ForecastViewControllerSpy()
    
    private lazy var sut: ForecastPresenter = {
        let presenter = ForecastPresenter()
        presenter.viewController = viewControllerSpy
        return presenter
    }()
    
    func test_presentCurrentForecast_shouldCallViewControllerWithCorrectParams() {
        let temperature: Double = 27
        sut.presentCurrentForecast(response: .init(temperature: temperature))
        
        XCTAssertEqual(viewControllerSpy.displayCurrentForecastCallCount, 1)
        XCTAssertEqual(viewControllerSpy.displayCurrentForecastViewModelPassed?.temperature, temperature)
    }
    
}
