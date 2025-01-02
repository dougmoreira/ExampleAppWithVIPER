public protocol ForecastBusinessLogic {
    func didLoad(request: CurrentForecastModel.Request)
}

final class ForecastInteractor: ForecastBusinessLogic {
    private let presenter: ForecastPresentationLogic
    
    init(presenter: ForecastPresentationLogic) {
        self.presenter = presenter
    }
    
    func didLoad(request: CurrentForecastModel.Request) {
        presenter.presentCurrentForecast(with: .init())
    }
}
