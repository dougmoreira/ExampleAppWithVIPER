public enum CurrentForecastModel {
    public struct Request { }
    public struct Response { }
    public struct ViewModel { }
}

public struct Forecast: Decodable {
    public let currentWeather: CurrentWeather
}

public struct CurrentWeather: Decodable {
    public let temperature: Double
}

public enum ForecastError: Error {
    case genericErrorCode(String)
}
