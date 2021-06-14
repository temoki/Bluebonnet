import Foundation

extension Request {
    var httpMethod: HTTPMethod { .get }

    var queryParameters: [(name: String, value: String?)] { [] }

    var bodyParameters: Encodable? { nil }
    var bodyEncoder: BodyDataEncoder { JSONEncoder() }
    var bodyContentType: String { "application/json" }

    var headerFields: [String: String] { [:] }
    var additionalHeaderFields: [String: String] { [:] }
}
