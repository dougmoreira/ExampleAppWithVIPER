import ExampleApp

final class ForecastPresenterSpy: ForecastPresentationLogic {
    public private(set) var presentCurrentForecastCallCount: Int = 0
    public private(set) var presentCurrentForecastResponsePassed: CurrentForecastModel.Response?
    
    func presentCurrentForecast(response: CurrentForecastModel.Response) {
        presentCurrentForecastCallCount += 1
        presentCurrentForecastResponsePassed = response
    }
    
    public private(set) var presentIsLoadingCallCount: Int = 0
    public private(set) var presentIsLoadingResponsePassed: ViewState.Response?
    
    func presentIsLoading(response: ViewState.Response) {
        presentIsLoadingCallCount += 1
        presentIsLoadingResponsePassed = response
    }
}
