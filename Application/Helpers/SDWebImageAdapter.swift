import Foundation
import SDWebImage

extension UIImageView {
    func setImage(with url: String, placeholder: UIImage? = UIImage(named: "square")) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: url), placeholderImage: placeholder)
    }
}
