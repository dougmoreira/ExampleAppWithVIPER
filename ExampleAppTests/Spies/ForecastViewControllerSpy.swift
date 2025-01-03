import ExampleApp

final class ForecastViewControllerSpy: ForecastDisplayLogic {
    public private(set) var displayCurrentForecastCallCount: Int = 0
    public private(set) var displayCurrentForecastViewModelPassed: CurrentForecastModel.ViewModel?
    
    func displayCurrentForecast(viewModel: CurrentForecastModel.ViewModel) {
        displayCurrentForecastCallCount += 1
        displayCurrentForecastViewModelPassed = viewModel
    }
    
    public private(set) var isLoadingCallCount: Int = 0
    public private(set) var isLoadingViewModelPassed: ViewState.ViewModel?
    
    func isLoading(viewModel: ViewState.ViewModel) {
        isLoadingCallCount += 1
        isLoadingViewModelPassed = viewModel
    }
}
