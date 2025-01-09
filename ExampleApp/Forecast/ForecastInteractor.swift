public protocol ForecastBusinessLogic {
    func fetchCurrentTemperature(request: CurrentForecastModel.Request)
    func fetchForecast()
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
    
    func fetchForecast() {
        self.presenter.presentState(response: .init(isLoading: true, error: nil))
        Task { [weak self] in
            guard let self = self else { return }
            
            do {
                let response = try await self.getCurrentTemperature.getForecast()
                if let temperature = response?.temperature {
                    self.presenter.presentCurrentForecast(response: .init(temperature: temperature))
                    self.presenter.presentState(response: .init(isLoading: false, error: nil))
                } else {
                    self.presenter.presentState(response: .init(isLoading: false, error: true))
                }
            } catch {
                self.presenter.presentState(response: .init(isLoading: false, error: true))
            }
        }
    }
}
