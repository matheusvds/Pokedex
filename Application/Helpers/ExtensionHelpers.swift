import Foundation
import UIKit

// MARK: - Int
extension Int {
    func toString() -> String {
        return String(self)
    }
}

// MARK: - View Controller
extension UIViewController {
    func showAlert(title: String, message: String, handler: (() -> Void)? = nil) {
        if message.isEmpty {
            return
        }
            
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(title: "Ok", style: .default, handler: { _ in
                handler?()
            })
        )
        
        present(alert, animated: true, completion: nil)
    }
}
