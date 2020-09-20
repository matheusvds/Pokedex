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
    
    public init(name: String, value: String? = nil) {
        self.name = name
        self.value = value
    }
}
