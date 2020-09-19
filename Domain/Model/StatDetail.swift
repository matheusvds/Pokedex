import Foundation

// MARK: - Stat
public struct StatDetail: Codable {
    public let affectingMoves: AffectingMove
    public let affectingNatures: AffectingNature
    public let isBattleOnly: Bool
    public let names: [Name]

    enum CodingKeys: String, CodingKey {
        case affectingMoves = "affecting_moves"
        case affectingNatures = "affecting_natures"
        case isBattleOnly = "is_battle_only"
        case names
    }
    
    public struct Name: Codable {
        public let language: Reference
        public let name: String
    }
    
    public struct EffectType: Codable {
        public let move: Reference
    }


    public struct AffectingMove: Codable {
       public  let decrease: [EffectType]
        public let increase: [EffectType]
    }
    
    public struct AffectingNature: Codable {
       public  let decrease: [Reference]
        public let increase: [Reference]
    }
}


