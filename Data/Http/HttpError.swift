import Foundation

public enum HttpError: Error {
    case requestFailed
    case responseUnsuccessful
    case jsonParsingFailure
}
