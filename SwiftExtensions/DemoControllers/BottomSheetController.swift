import UIKit
class BottomSheetController: UIViewController, BottomSheetHost {
    
    private let bottomSheet: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .close)
        return button
    }()
    
    var closeAction: (() -> Void)?
    
    var sheetOriginY: CGFloat = 0
    let sheetPanGesture = UIPanGestureRecognizer()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        sheetPanGesture.addTarget(self, action: #selector(handleSheetPan))
        bottomSheet.addGestureRecognizer(sheetPanGesture)
        
        closeButton.addTarget(self,
                              action: #selector(handleClose),
                              for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheetOriginY = 0.8 * view.frame.maxY
        layoutViews()
    }
    
    private func layoutViews() {
        layoutSheet()
        view.backgroundColor = UIColor.purple
        view.addSubview(bottomSheet)
        bottomSheet.frame = CGRect(x: 0,
                                   y: sheetOriginY,
                                   width: view.bounds.width,
                                   height: view.bounds.height)
    }
    
    private func layoutSheet() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        bottomSheet.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: bottomSheet.topAnchor, constant: 10.0).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: bottomSheet.trailingAnchor, constant: -10.0).isActive = true
    }
    
    @objc private func handleSheetPan() {
        translateSheet()
    }
    
    @objc private func handleClose() {
        closeAction?()
    }
}
