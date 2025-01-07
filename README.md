# Testing API Layer

A simple iOS app demonstrating the usage of the **VIPER architecture** and network requests using `URLSession`. This project showcases how to implement and test the network layer effectively in a modular and scalable manner, adhering to VIPER principles.

---

## Key Features

- **VIPER Architecture**:
  - The app is structured into five distinct components: **View**, **Interactor**, **Presenter**, **Entity**, and **Router**.
  - Each component has a specific responsibility, ensuring high cohesion and low coupling.

- **Real-Time Weather Fetching**:
  - Fetches weather data using the [Open-Meteo API](https://open-meteo.com/).
  - Displays the current temperature for Belo Horizonte, MG.

- **Testable Network Layer**:
  - Abstraction of network calls using `NetworkServiceProtocol` allows mocking during tests.
  - Comprehensive tests validate success and failure scenarios.

---

## VIPER Architecture

The app is structured using the **VIPER** architectural pattern, which divides the app logic into the following layers:

1. **View**:
   - Displays data and captures user interactions.
   - Updates are triggered by the presenter.
   
   Example: `ForecastViewController`

2. **Interactor**:
   - Contains business logic and handles network calls.
   - Communicates results back to the presenter.
   
   Example: `ForecastInteractor`

3. **Presenter**:
   - Prepares data for the view and handles user input.
   - Serves as the bridge between the view and interactor.
   
   Example: `ForecastPresenter`

4. **Entity**:
   - Defines the data models used in the app.
   
   Example: `Temperature` (data model for temperature response).

5. **Router**:
   - Manages navigation between screens.
   
   Example: `ForecastRouter`

---

## How It Works

Here’s how the flow works in this project:

1. **Configurator**:
   - The `ForecastConfigurator` resolves dependencies and sets up the VIPER layers.
   - Example:
     ```swift
     final class ForecastConfigurator: ForecastConfiguratorProtocol {
         func resolveViewController() -> UIViewController {
             let networkService: NetworkServiceProtocol = URLSessionNetworkService()
             let urlString = "https://api.open-meteo.com/v1/forecast?latitude=-19.9208&longitude=-43.9378&hourly=temperature_2m&current_weather=true&forecast_days=1"
             let temperatureService = GetCurrentTemperature(network: networkService, urlString: urlString)
             
             let presenter = ForecastPresenter()
             let interactor = ForecastInteractor(presenter: presenter, getCurrentTemperature: temperatureService)
             let viewController = ForecastViewController(interactor: interactor)
             
             presenter.viewController = viewController
             
             return viewController
         }
     }
     ```

2. **Network Requests**:
   - The `GetCurrentTemperature` service handles API requests using a `NetworkServiceProtocol` abstraction.
   - The interactor calls this service to fetch data.

3. **Testable Network Layer**:
   - The network layer is abstracted using a protocol (`NetworkServiceProtocol`), allowing easy mocking during tests.

---

## Example of URLSession Mock

The project includes a `URLSessionMock` to simulate network responses during unit tests:

```swift
class URLSessionMock: NetworkServiceProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func performRequest(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completion(data, response, error)
    }
}
