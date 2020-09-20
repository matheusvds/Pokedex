import Foundation
import UIKit

public struct GamesViewModel {
    public let games: [GameProperty]
    
    public init(games: [GameProperty]) {
        self.games = games
    }
}

public class GameProperty: Item {
    
    static var cellType: AnyClass {
        return GameCell.self
    }
    
    var name: String?
    var value: String?
    
    public init(name: String) {
        self.name = name
    }
}
