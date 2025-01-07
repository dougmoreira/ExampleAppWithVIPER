import Foundation

public protocol GetCurrentTemperatureUseCase {
    func getTemperature(completion: @escaping (Result<CurrentWeather?, ForecastError>) -> Void)
}

final class GetCurrentTemperature: GetCurrentTemperatureUseCase {
    private let network: URLSessionProtocol
    
    init(network: URLSessionProtocol) {
        self.network = network
    }
    
    func getTemperature(completion: @escaping (Result<CurrentWeather?, ForecastError>) -> Void) {
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=-19.9208&longitude=-43.9378&hourly=temperature_2m&current_weather=true&forecast_days=1") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let dataTask = network.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completion(.failure(.genericError))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidStatusCode))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            let decode = JSONDecoder()
            decode.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let decodedData = try decode.decode(Forecast.self, from: data)
                completion(.success(decodedData.currentWeather))
            } catch {
                completion(.failure(.invalidDecodedData))
            }
        }
        
        dataTask.resume()
    }
}
