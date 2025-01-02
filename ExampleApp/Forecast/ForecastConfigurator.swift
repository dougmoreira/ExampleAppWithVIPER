import UIKit

public protocol ForecastConfiguratorProtocol {
    func resolveViewController() -> UIViewController
}

final class ForecastConfigurator: ForecastConfiguratorProtocol {
    func resolveViewController() -> UIViewController {
        let presenter = ForecastPresenter()
        let interactor = ForecastInteractor(presenter: presenter)
        let viewController = ForecastViewController(interactor: interactor)
        presenter.viewController = viewController
        
        return viewController
    }
}
