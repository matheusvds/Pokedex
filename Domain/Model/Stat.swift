import Foundation

public struct Stat: Model {
    public let baseStat: Int
    public let effort: Int
    public let stat: Reference

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}
