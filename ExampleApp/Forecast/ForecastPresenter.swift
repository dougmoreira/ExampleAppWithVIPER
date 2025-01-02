public protocol ForecastPresentationLogic {
    func presentCurrentForecast(with response: CurrentForecastModel.Response)
}

final class ForecastPresenter: ForecastPresentationLogic {
    weak var viewController: ForecastDisplayLogic?
    
    func presentCurrentForecast(with response: CurrentForecastModel.Response) {
        viewController?.displayCurrentForecast(viewModel: .init(temperature: response.temperature))
    }
}
