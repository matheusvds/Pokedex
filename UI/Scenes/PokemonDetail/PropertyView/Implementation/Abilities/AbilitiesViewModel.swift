import Foundation
import UIKit

public struct AbilitiesViewModel {
    public let abilities: [AbilityProperty]
    
    public init(abilities: [AbilityProperty]) {
        self.abilities = abilities
    }
}

public class AbilityProperty: Item {
    
    static var cellType: AnyClass {
        return AbilityCell.self
    }
    
    var name: String?
    var value: String?
    var link: String?
    
    public init(name: String, link: String) {
        self.name = name
        self.link = link
    }
}
