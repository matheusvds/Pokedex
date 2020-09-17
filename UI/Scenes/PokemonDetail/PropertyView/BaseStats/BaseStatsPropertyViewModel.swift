import Foundation

 public struct BaseStatsPropertyViewModel {
    public let stats: [BaseStatProperty]
    
    public init(stats: [BaseStatProperty]) {
        self.stats = stats
    }
    
    public struct BaseStatProperty {
        public let name: String
        public let value: String
        public let link: String
        
        public init(name: String, value: String, link: String) {
            self.name = name
            self.value = value
            self.link = link
        }
    }
 }
