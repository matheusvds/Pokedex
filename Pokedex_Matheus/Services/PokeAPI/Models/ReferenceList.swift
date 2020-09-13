import Foundation

public struct ReferenceList: Model {
    public let count: Int
    public let next: String?
    public let previous: String?
    public let results: [Reference]
    
    public init(count: Int, next: String?, previous: String?, results: [Reference]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}
