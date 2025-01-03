public protocol ForecastPresentationLogic {
    func presentCurrentForecast(response: CurrentForecastModel.Response)
    func presentIsLoading(response: ViewState.Response)
}

final class ForecastPresenter: ForecastPresentationLogic {
    weak var viewController: ForecastDisplayLogic?
    
    func presentCurrentForecast(response: CurrentForecastModel.Response) {
        viewController?.displayCurrentForecast(viewModel: .init(temperature: response.temperature))
    }
    
    func presentIsLoading(response: ViewState.Response) {
        viewController?.isLoading(viewModel: .init(isLoading: response.isLoading))
    }
}
