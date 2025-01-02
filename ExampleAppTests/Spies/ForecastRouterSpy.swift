import ExampleApp

final class ForecastRouterSpy: ForecastRoutingLogic {
    public private(set) var routeToForecastDetailsCallCount: Int = 0
    
    func routeToForecastDetails() {
        routeToForecastDetailsCallCount += 1
    }
}
