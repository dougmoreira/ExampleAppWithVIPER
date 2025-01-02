public protocol ForecastBusinessLogic {
    func didLoad(request: CurrentForecastModel.Request)
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
    
    func didLoad(request: CurrentForecastModel.Request) {
        getCurrentTemperature.getTemperature { [weak self] result in
            switch result {
            case .success(let currentTemperature):
                if let temperature = currentTemperature?.temperature {
                    self?.presenter.presentCurrentForecast(with: .init(temperature: temperature))
                }
            case .failure:
                debugPrint("error") // to do
            }
        }
    }
}
