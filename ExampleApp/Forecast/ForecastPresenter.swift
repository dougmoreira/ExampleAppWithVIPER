public protocol ForecastPresentationLogic {
    func presentCurrentForecast(response: CurrentForecastModel.Response)
    func presentState(response: ViewState.Response)
}

final class ForecastPresenter: ForecastPresentationLogic {
    weak var viewController: ForecastDisplayLogic?
    
    func presentCurrentForecast(response: CurrentForecastModel.Response) {
        viewController?.displayCurrentForecast(viewModel: .init(temperature: response.temperature))
    }
    
    func presentState(response: ViewState.Response) {
        viewController?.displayState(
            viewModel: .init(
                isLoading: response.isLoading,
                error: response.error
            )
        )
    }
}
