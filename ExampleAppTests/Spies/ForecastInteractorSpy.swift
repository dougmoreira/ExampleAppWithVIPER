import ExampleApp

final class ForecastInteractorSpy: ForecastBusinessLogic {
    public private(set) var fetchCurrentTemperatureCallCount: Int = 0
    public private(set) var fetchCurrentTemperatureRequestPassed: CurrentForecastModel.Request?

    func fetchCurrentTemperature(request: CurrentForecastModel.Request) {
        fetchCurrentTemperatureCallCount += 1
        fetchCurrentTemperatureRequestPassed = request
    }
}
