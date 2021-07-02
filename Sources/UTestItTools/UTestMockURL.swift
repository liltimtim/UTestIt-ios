import Foundation

/*
 Provides the ability to control how a request handler should respond to a request.
 
 Usage:
 1. Define a requestHandler block which takes in the request
 2. Create an HTTPURLResponse with the given URL and status code that will be returned.
 3. Use the createMockSession to assign this custom session to any URLSession library that is used.
 */
class MockURLProtocol: URLProtocol {
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("Handler is unavailable.")
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    override func stopLoading() {
        
    }
}
/**
 Creates a Mock URL session that uses the MockURLProtocol implementation to provide custom and controllable responses.
 */
extension MockURLProtocol {
    static func createMockSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }
}
