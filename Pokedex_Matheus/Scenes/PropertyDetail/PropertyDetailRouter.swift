import Foundation
import UIKit

typealias PropertyDetailRouterLogic = (PropertyDetailRoutingLogic & PropertyDetailDataPassing)?

protocol PropertyDetailRoutingLogic {
}

protocol PropertyDetailDataPassing {
    var dataStore: PropertyDetailDataStore? { get }
}

class PropertyDetailRouter: PropertyDetailRoutingLogic, PropertyDetailDataPassing {
    weak var viewController: UIViewController?
    var dataStore: PropertyDetailDataStore?
}
