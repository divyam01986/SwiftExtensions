import UIKit

extension UIViewController {
    func hideNavBarDefaultIcon() {
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
    }
}
