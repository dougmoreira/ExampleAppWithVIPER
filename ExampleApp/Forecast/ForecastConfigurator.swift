import UIKit

public protocol ForecastConfiguratorProtocol {
    func resolveViewController() -> UIViewController
}

final class ForecastConfigurator: ForecastConfiguratorProtocol {
    func resolveViewController() -> UIViewController {
        let presenter = ForecastPresenter()
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=-19.9208&longitude=-43.9378&hourly=temperature_2m&current_weather=true&forecast_days=1"
        let getCurrentTemperture = GetCurrentTemperature(
            network: URLSession.shared, urlString: urlString
        )
        let interactor = ForecastInteractor(
            presenter: presenter,
            getCurrentTemperature: getCurrentTemperture
        )
        let viewController = ForecastViewController(interactor: interactor)
        presenter.viewController = viewController
        
        return viewController
    }
}
