import UIKit

extension UIViewController {
    func hideNavBarDefaultIcon() {
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
    }
    
    func addChildController(_ controller: UIViewController, addChildView: Bool = true) {
        if addChildView {
            view.addSubview(controller.view)
        }
        
        addChild(controller)
        
        controller.didMove(toParent: self)
    }
    
    func removeFromParentController() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
