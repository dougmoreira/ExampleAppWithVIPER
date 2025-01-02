import UIKit

public protocol ForecastDisplayLogic: AnyObject {
    func displayCurrentForecast(viewModel: CurrentForecastModel.ViewModel)
}

final class ForecastViewController: UIViewController, ForecastDisplayLogic {
    private let interactor: ForecastBusinessLogic
    
    init(interactor: ForecastBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.didLoad(request: .init())
    }
    
    func displayCurrentForecast(viewModel: CurrentForecastModel.ViewModel) {
        
    }
}
