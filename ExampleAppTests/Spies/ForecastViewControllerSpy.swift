import ExampleApp

final class ForecastViewControllerSpy: ForecastDisplayLogic {
    public private(set) var displayStateCallCount: Int = 0
    public private(set) var displayStateViewModelPassed: ViewState.ViewModel?
    
    func displayState(viewModel: ViewState.ViewModel) {
        displayStateCallCount += 1
        displayStateViewModelPassed = viewModel
    }
    
    public private(set) var displayCurrentForecastCallCount: Int = 0
    public private(set) var displayCurrentForecastViewModelPassed: CurrentForecastModel.ViewModel?
    
    func displayCurrentForecast(viewModel: CurrentForecastModel.ViewModel) {
        displayCurrentForecastCallCount += 1
        displayCurrentForecastViewModelPassed = viewModel
    }
}
