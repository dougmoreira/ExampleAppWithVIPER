public protocol ForecastBusinessLogic {
    func fetchCurrentTemperature(request: CurrentForecastModel.Request)
}

final class ForecastInteractor: ForecastBusinessLogic {
    private let presenter: ForecastPresentationLogic
    private let getCurrentTemperature: GetCurrentTemperatureUseCase
    
    init(
        presenter: ForecastPresentationLogic,
        getCurrentTemperature: GetCurrentTemperatureUseCase
    ) {
        self.presenter = presenter
        self.getCurrentTemperature = getCurrentTemperature
    }
    
    func fetchCurrentTemperature(request: CurrentForecastModel.Request) {
        presenter.presentIsLoading(response: .init(isLoading: true))
        getCurrentTemperature.getTemperature { [weak self] result in
            switch result {
            case .success(let currentTemperature):
                if let temperature = currentTemperature?.temperature {
                    self?.presenter.presentCurrentForecast(
                        response: .init(temperature: temperature)
                    )
                    self?.presenter.presentIsLoading(response: .init(isLoading: false))
                }
            case .failure:
                debugPrint("error") // to do error state
            }
        }
    }
}
