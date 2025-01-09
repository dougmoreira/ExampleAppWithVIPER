import ExampleApp

final class GetCurrentTemperatureSpy: GetCurrentTemperatureUseCase {
    public private(set) var getForecastCallCount: Int = 0
    public private(set) var getForecastToBeReturned: Result<CurrentWeather?, ForecastError>?
    
    func getForecast() async throws -> CurrentWeather? {
        getForecastCallCount += 1
        
        if let getForecastToBeReturned = getForecastToBeReturned {
            switch getForecastToBeReturned {
            case .success(let success):
                return success
            case .failure(let failure):
                throw failure
            }
        }
        
        throw ForecastError.genericError
    }
    
    private(set) var getTemperatureCallCount: Int = 0
    var completionToBeReturned: Result<CurrentWeather?, ForecastError>?
    
    func getTemperature(completion: @escaping (Result<CurrentWeather?, ForecastError>) -> Void) {
        getTemperatureCallCount += 1
        
        if let completionToBeReturned = completionToBeReturned {
            completion(completionToBeReturned)
        }
    }
}
