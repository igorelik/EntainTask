import Foundation

enum NetworkError: Error {
    case general(error: Error)
    case invalidURL
    case transportError(String?)
    case apiError(statusCode: Int)
}

