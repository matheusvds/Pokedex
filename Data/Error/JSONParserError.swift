import Foundation

public enum RequestError: Error {
    case requestFailed
    case responseUnsuccessful
    case jsonParsingFailure
}
