import Foundation

public protocol Request {
    static var baseURL: URL { get }
    static var headerFields: [String: String] { get }
    static var bodyEncoder: BodyEncoder { get }
    static var bodyContentType: String { get }

    var path: String { get }
    var method: Method { get }
    var queryParameters: [(name: String, value: String?)] { get }
    var bodyParameters: Encodable? { get }
    var additionalHeaderFields: [String: String] { get }
}

extension Request {
    static var headerFields: [String: String] { [:] }
    static var bodyEncoder: BodyEncoder { JSONEncoder() }
    static var bodyContentType: String { "application/json" }
    var method: Method { .get }
    var queryParameters: [(name: String, value: String?)] { [] }
    var bodyParameters: Encodable? { nil }
    var additionalHeaderFields: [String: String] { [:] }
}

public struct SimpleError: CustomNSError {
}

extension Request {
    public func make() throws -> URLRequest {
        // URL
        let url = path.isEmpty ? Self.baseURL : Self.baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        
        // Method
        urlRequest.httpMethod = method.rawValue

        // Query
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw SimpleError()
        }
        let queryItems: [URLQueryItem] = queryParameters.map { .init(name: $0.name, value: $0.value) }
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
        guard let urlWithQuery = urlComponents.url else {
            throw SimpleError()
        }
        urlRequest.url = urlWithQuery

        // Body
        if let bodyParameters = self.bodyParameters {
            urlRequest.setValue(Self.bodyContentType, forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try bodyParameters.encoded(by: Self.bodyEncoder)
        }
        
        // Header
        Self.headerFields.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        additionalHeaderFields.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
}
