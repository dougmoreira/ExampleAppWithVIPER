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
        presenter.presentState(response: .init(isLoading: true, error: nil))
        getCurrentTemperature.getTemperature { [weak self] result in
            switch result {
            case .success(let currentTemperature):
                if let temperature = currentTemperature?.temperature {
                    self?.presenter.presentCurrentForecast(
                        response: .init(temperature: temperature)
                    )
                    self?.presenter.presentState(
                        response: .init(
                            isLoading: false,
                            error: nil
                        )
                    )
                }
            case .failure:
                self?.presenter.presentState(
                    response: .init(
                        isLoading: false,
                        error: true
                    )
                )
            }
        }
    }
}
