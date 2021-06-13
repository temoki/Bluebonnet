import Foundation

public protocol BodyEncoder {
    func encode<T>(_ value: T) throws -> Data where T : Encodable
}

extension Encodable {
    func encoded(by encoder: BodyEncoder) throws -> Data {
        try encoder.encode(self)
    }
}

extension JSONEncoder: BodyEncoder {
}
