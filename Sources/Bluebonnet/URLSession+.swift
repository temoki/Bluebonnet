import Foundation

extension URLSession {
    public func dataTask(with request: Request) throws -> URLSessionDataTask {
        dataTask(with: try request.make())
    }
    
    public func dataTask(with request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) throws -> URLSessionDataTask {
        dataTask(with: try request.make(), completionHandler: completionHandler)
    }
}
