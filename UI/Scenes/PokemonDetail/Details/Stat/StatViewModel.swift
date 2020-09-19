import Foundation

public struct StatViewModel {
    public let title: String?
    public let items: [Section]
    public init(title: String?, items: [Section]) {
        self.title = title
        self.items = items
    }
}

public struct Section {
    public let name: String
    public let items: [String]
    public init(name: String, items: [String]) {
        self.name = name
        self.items = items
    }
}
