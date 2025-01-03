public enum CurrentForecastModel {
    public struct Request { }
    public struct Response {
        let temperature: Double
    }
    public struct ViewModel {
        let temperature: Double
    }
}

public enum ViewState {
    public struct Request { }
    public struct Response {
        let isLoading: Bool
    }
    public struct ViewModel {
        let isLoading: Bool
    }
}

public struct Forecast: Decodable {
    public let currentWeather: CurrentWeather
}

public struct CurrentWeather: Decodable {
    public let temperature: Double
}

public enum ForecastError: Error {
    case genericError
    case invalidURL
    case invalidStatusCode
    case invalidData
    case invalidDecodedData
}
