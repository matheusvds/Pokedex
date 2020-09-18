import Foundation

public struct BaseStatsPropertyViewModel {
    public let stats: [BaseStatProperty]
    
    public init(stats: [BaseStatProperty]) {
        self.stats = stats
    }
}

public class BaseStatProperty: Item {
    
    static var cellType: AnyClass {
        return StatCell.self
    }
    
    var name: String?
    var value: String?
    var link: String?
    
    public init(name: String, value: String, link: String) {
        self.name = name
        self.value = value
        self.link = link
    }
}
