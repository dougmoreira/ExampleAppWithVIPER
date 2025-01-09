import Foundation
import ExampleApp

class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
        let dataTask = URLSessionDataTaskMock {
            completionHandler(self.data, self.response, self.error)
        }
        
        return dataTask
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        guard let data = self.data, let response = self.response else {
            throw error ?? ForecastError.genericError
        }
        
        return (data, response)
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
