import Foundation

extension Data {
    func toModel<T: Decodable>() -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: self)
        } catch {
            print(error)
            return nil
        }
    }
}
