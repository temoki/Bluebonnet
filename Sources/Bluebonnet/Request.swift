import Foundation

public protocol Request {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }

    var queryParameters: [(name: String, value: String?)] { get }

    var bodyParameters: Encodable? { get }
    var bodyEncoder: BodyDataEncoder { get }
    var bodyContentType: String { get }

    var headerFields: [String: String] { get }
    var additionalHeaderFields: [String: String] { get }
}
