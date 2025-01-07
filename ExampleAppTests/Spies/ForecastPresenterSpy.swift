import ExampleApp

final class ForecastPresenterSpy: ForecastPresentationLogic {
    public private(set) var presentStateCallCount: Int = 0
    public private(set) var presentStateResponsePassed: ViewState.Response?
    
    func presentState(response: ViewState.Response) {
        presentStateCallCount += 1
        presentStateResponsePassed = response
    }
    
    public private(set) var presentCurrentForecastCallCount: Int = 0
    public private(set) var presentCurrentForecastResponsePassed: CurrentForecastModel.Response?
    
    func presentCurrentForecast(response: CurrentForecastModel.Response) {
        presentCurrentForecastCallCount += 1
        presentCurrentForecastResponsePassed = response
    }
}
