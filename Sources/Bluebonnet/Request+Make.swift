import Foundation

extension Request {
    public func make() throws -> URLRequest {
        // URL
        let url = path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        
        // Method
        urlRequest.httpMethod = httpMethod.rawValue

        // Query
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw RequestMakeError.malformedURL(url, [])
        }
        let queryItems: [URLQueryItem] = queryParameters.map { .init(name: $0.name, value: $0.value) }
        urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
        guard let urlWithQuery = urlComponents.url else {
            throw RequestMakeError.malformedURL(url, queryItems)
        }
        urlRequest.url = urlWithQuery

        // Body
        if let bodyParameters = self.bodyParameters {
            urlRequest.setValue(bodyContentType, forHTTPHeaderField: "Content-Type")
            do {
                urlRequest.httpBody = try bodyParameters.encoded(by: bodyEncoder)
            } catch let error {
                throw RequestMakeError.bodyEncoderError(error)
            }
        }
        
        // Headers
        headerFields.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        additionalHeaderFields.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
}
