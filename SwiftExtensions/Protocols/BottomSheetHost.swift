import UIKit
/**
    This protocol contains reusable code to create a bottom sheet that translates vertically (along the y-axis) in response to user pan gestures.
    The sheet view must be added using frames (see BottomSheetController for example)
 */
protocol BottomSheetHost where Self: UIViewController {
    var sheetOriginY: CGFloat { get } // Initial Y coordinate of the bottom sheet
    var sheetPanGesture: UIPanGestureRecognizer { get }
    
    func translateSheet()
}

extension BottomSheetHost {
    func translateSheet() {
        guard let gestureView = sheetPanGesture.view else {
            debugPrint("error no view associated with gesture")
            return
        }
        
        let deltaY = sheetPanGesture.translation(in: view).y
        let velocityY = sheetPanGesture.velocity(in: view).y
        
        let state = sheetPanGesture.state
        switch state {
        case .changed:
            let finalY: CGFloat
            let time: TimeInterval
            
            if deltaY < 0 {
                finalY = max(0, gestureView.frame.origin.y + deltaY)
            } else {
                finalY = min(sheetOriginY, gestureView.frame.origin.y + deltaY)
            }
            time = TimeInterval(abs(deltaY / velocityY))
            UIView.animate(withDuration: time,
                           animations: {
                            gestureView.frame.origin.y = finalY
            }, completion: { [unowned self]_ in
                self.sheetPanGesture.setTranslation(.zero, in: self.view)
            })
        case .ended:
            let thresholdY = 0.5 * sheetOriginY
            let destY = gestureView.frame.origin.y <= thresholdY ? 0 : sheetOriginY
            
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [.curveEaseOut],
                           animations: {
                            gestureView.frame.origin.y = destY
            }, completion: nil)
        default:
            break
        }
    }
}
