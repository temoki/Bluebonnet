import Foundation

public protocol BodyDataEncoder {
    func encode<T>(_ value: T) throws -> Data where T : Encodable
}

extension JSONEncoder: BodyDataEncoder {}

extension Encodable {
    internal func encoded(by encoder: BodyDataEncoder) throws -> Data {
        try encoder.encode(self)
    }
}
