public protocol GetCurrentTemperatureUseCase {
    func getTemperature(completion: @escaping (Result<CurrentWeather?, ForecastError>) -> Void)
}

final class GetCurrentTemperature: GetCurrentTemperatureUseCase {
    func getTemperature(completion: @escaping (Result<CurrentWeather?, ForecastError>) -> Void) {
        
    }
}
