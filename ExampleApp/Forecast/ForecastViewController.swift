import UIKit

public protocol ForecastDisplayLogic: AnyObject {
    func displayCurrentForecast(viewModel: CurrentForecastModel.ViewModel)
}

final class ForecastViewController: UIViewController {
    private let interactor: ForecastBusinessLogic
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .extraLargeTitle)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.addArrangedSubview(temperatureLabel)
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    init(interactor: ForecastBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        
        addSubviews()
        constrainSubviews()
        view.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor.didLoad(request: .init())
    }
}

extension ForecastViewController {
    private func addSubviews() {
        view.addSubview(mainStackView)
    }
    
    private func constrainSubviews() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ForecastViewController: ForecastDisplayLogic {
    func displayCurrentForecast(viewModel: CurrentForecastModel.ViewModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(viewModel.temperature)ºC"
        }
    }
}
