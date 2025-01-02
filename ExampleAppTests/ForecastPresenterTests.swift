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
    
    func test_() {
        sut.presentCurrentForecast(with: .init())
        
        XCTAssertEqual(viewControllerSpy.displayCurrentForecastCallCount, 1)
    }
    
}
