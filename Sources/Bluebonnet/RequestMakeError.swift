import Foundation

public enum RequestMakeError {
    case malformedURL(URL, [URLQueryItem])
    case bodyEncoderError(Error)
}

extension RequestMakeError: CustomNSError {
    public var errorUserInfo: [String : Any] {
        switch self {
        case let .malformedURL(url, queryItems):
            return ["url": url, "query_items": queryItems]
        case let .bodyEncoderError(error):
            return [NSUnderlyingErrorKey: error]
        }
    }
}
