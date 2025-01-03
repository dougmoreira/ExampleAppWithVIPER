import ExampleApp

final class GetCurrentTemperatureSpy: GetCurrentTemperatureUseCase {
    private(set) var getTemperatureCallCount: Int = 0
    var completionToBeReturned: Result<CurrentWeather?, ForecastError>?
    
    func getTemperature(completion: @escaping (Result<CurrentWeather?, ForecastError>) -> Void) {
        getTemperatureCallCount += 1
        
        if let completionToBeReturned = completionToBeReturned {
            completion(completionToBeReturned)
        }
    }
}
