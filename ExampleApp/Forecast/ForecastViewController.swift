import UIKit

public protocol ForecastDisplayLogic: AnyObject {
    func displayCurrentForecast(viewModel: CurrentForecastModel.ViewModel)
    func displayState(viewModel: ViewState.ViewModel)
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
    
    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Failure. Try again", for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(didTapTryAgainButton), for: .touchUpInside)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let cityName: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Belo Horizonte, Brazil"
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            loadingIndicator,
            temperatureLabel,
            cityName,
            tryAgainButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 12
        return stackView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .white
        view.isHidden = true
        view.startAnimating()
        return view
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
        interactor.fetchForecast()
    }
}

extension ForecastViewController {
    private func addSubviews() {
        view.addSubview(mainStackView)
    }
    
    private func constrainSubviews() {
        constrainMainStackView()
        constrainTryAgainButton()
    }
    
    private func constrainTryAgainButton() {
        NSLayoutConstraint.activate([
            tryAgainButton.heightAnchor.constraint(equalToConstant: 40),
            tryAgainButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func constrainMainStackView() {
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension ForecastViewController: ForecastDisplayLogic {
    func displayState(viewModel: ViewState.ViewModel) {
        DispatchQueue.main.async {
            self.loadingIndicator.isHidden = viewModel.isLoading ? false : true
            self.tryAgainButton.isHidden = viewModel.error == true ? false : true
        }
    }
    
    func displayCurrentForecast(viewModel: CurrentForecastModel.ViewModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(viewModel.temperature) ºC"
        }
    }
}

extension ForecastViewController {
    @objc func didTapTryAgainButton() {
        interactor.fetchCurrentTemperature(request: .init())
    }
}
