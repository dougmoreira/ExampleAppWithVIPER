import UIKit

public protocol ForecastConfiguratorProtocol {
    func resolveViewController() -> UIViewController
}

final class ForecastConfigurator: ForecastConfiguratorProtocol {
    func resolveViewController() -> UIViewController {
        let presenter = ForecastPresenter()
        let getCurrentTemperture = GetCurrentTemperature()
        let interactor = ForecastInteractor(
            presenter: presenter,
            getCurrentTemperature: getCurrentTemperture
        )
        let viewController = ForecastViewController(interactor: interactor)
        presenter.viewController = viewController
        
        return viewController
    }
}
