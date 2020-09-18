import Foundation

typealias Item = ItemDetailable & CellTypeAssociatable & Identifiable

protocol ItemDetailable {
    var name: String? { get }
    var value: String? { get }
    var link: String? { get }
}

protocol CellTypeAssociatable {
    static var cellType: AnyClass { get }
}
