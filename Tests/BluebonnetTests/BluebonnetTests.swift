import XCTest
@testable import Bluebonnet

protocol GitHubRequest: Request {
}

extension GitHubRequest {
    static var baseURL: URL { URL(string: "https://api.github.com")! }
}

struct GitHubUserRequest: GitHubRequest {
    var username: String
    var accessToken: String?
    
    var path: String {
        "/users/\(username)"
    }

    var queryParameters: [(name: String, value: String?)] {
        accessToken.flatMap { [(name: "access_token", value: $0)] } ?? []
    }
}

final class BluebonnetTests: XCTestCase {
    func testExample() {
        do {
            let request = try GitHubUserRequest(username: "temoki").make()
            let expectation = self.expectation(description: #function)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                print(String(data: data!, encoding: .utf8)!)
                expectation.fulfill()
            }
            task.resume()
            wait(for: [expectation], timeout: 10)
        } catch {
            print(error)
        }
    }
}
