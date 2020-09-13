import Foundation

enum HttpError: Error {
    case requestFailed
    case responseUnsuccessful
    case jsonParsingFailure
}
