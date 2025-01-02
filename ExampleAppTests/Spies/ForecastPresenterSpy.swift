import ExampleApp

final class ForecastPresenterSpy: ForecastPresentationLogic {
    public private(set) var presentCurrentForecastCallCount: Int = 0
    public private(set) var presentCurrentForecastResponsePassed: CurrentForecastModel.Response?
    
    func presentCurrentForecast(with response: CurrentForecastModel.Response) {
        presentCurrentForecastCallCount += 1
        presentCurrentForecastResponsePassed = response
    }
}
