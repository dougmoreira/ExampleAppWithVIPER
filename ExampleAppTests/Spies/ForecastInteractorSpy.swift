import ExampleApp

final class ForecastInteractorSpy: ForecastBusinessLogic {
    public private(set) var didLoadCallCount: Int = 0
    public private(set) var didLoadRequestPassed: CurrentForecastModel.Request?

    func didLoad(request: CurrentForecastModel.Request) {
        didLoadCallCount += 1
        didLoadRequestPassed = request
    }
}
