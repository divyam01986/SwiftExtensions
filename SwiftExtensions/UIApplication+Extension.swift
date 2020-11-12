import UIKit

extension UIApplication {
    func visibleViewController() -> UIViewController? {
        guard let keyWindow = windows.filter({ $0.isKeyWindow }).first else {
            debugPrint("Error could not fetch key window")
            return nil
        }
        return keyWindow.rootViewController
    }
}
