import Foundation
import UIKit

enum ColorTheme: String {
    case normal
    case fire
    case water
    case electric
    case grass
    case ice
    case fighting
    case poison
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost
    case dragon
    case dark
    case steel
    case fairy
    
    var color: UIColor {
        switch self {
        case .normal:
            return UIColor(hex: 0xA8A77A)
        case .fire:
            return UIColor(hex: 0x9C531F)
        case .water:
            return UIColor(hex: 0x9DB7F5)
        case .electric:
            return UIColor(hex: 0xA1871F)
        case .grass:
            return UIColor(hex: 0x7AC74C)
        case .ice:
            return UIColor(hex: 0x96D9D6)
        case .fighting:
            return UIColor(hex: 0xC22E28)
        case .poison:
            return UIColor(hex: 0xA33EA1)
        case .ground:
            return UIColor(hex: 0xE2BF65)
        case .flying:
            return UIColor(hex: 0xA98FF3)
        case .psychic:
            return UIColor(hex: 0xF95587)
        case .bug:
            return UIColor(hex: 0xA6B91A)
        case .rock:
            return UIColor(hex: 0xB6A136)
        case .ghost:
            return UIColor(hex: 0x735797)
        case .dragon:
            return UIColor(hex: 0x6F35FC)
        case .dark:
            return UIColor(hex: 0x705746)
        case .steel:
            return UIColor(hex: 0xB7B7CE)
        case .fairy:
            return UIColor(hex: 0xD685AD)
        }
    }
}
