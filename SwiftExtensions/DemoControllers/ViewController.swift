import UIKit
import EasyPeasy
class ViewController: UIViewController {
    private lazy var stackView: UIStackView = {
        let vertStackView = UIStackView()
        vertStackView.axis = .vertical
        vertStackView.spacing = 8.0
        return vertStackView
    }()
    
    private lazy var superscriptLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subscriptLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let bottomsheetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bottom sheet", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private let slidingTabBarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sliding Tab bar demo", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()

    private let scrollView = UIScrollView()
    private let slidingTabBarChildVC: SlidingTabBarVC
    
    init() {
        self.slidingTabBarChildVC = SlidingTabBarVC(tabTitles: ["Left Option", "Middle Option", "Right Option"])
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addChildController(slidingTabBarChildVC, addChildView: false)
        slidingTabBarChildVC.onClose = {[weak self] in
            self?.showSlidingTabBarVC(show: false)
        }
        bottomsheetButton.addTarget(self, action: #selector(launchBottomSheet), for: .touchUpInside)
        slidingTabBarButton.addTarget(self, action: #selector(launchSlidingTabBarVC), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        layoutViews()
    }
    
    private func layoutViews() {
        guard let childView = slidingTabBarChildVC.view else {
            return
        }
        view.backgroundColor = UIColor.lightGray
        view.addSubview(childView)
        childView.isHidden = true
        childView.frame = CGRect(x: view.bounds.minX,
                                 y: view.bounds.maxY,
                                 width: view.bounds.width,
                                 height: view.bounds.height)
        view.addSubview(scrollView)
        scrollView.easy.layout(Top().to(view.safeAreaLayoutGuide, .top),
                               Left(),
                               Right(),
                               Bottom(),
                               Width(view.bounds.width))
        scrollView.addSubview(stackView)
        stackView.easy.layout(Edges())

        let text = "HelloYou"
        superscriptLabel.attributedText = TextFormatter.superscriptText(text: text,
                                                                        font: UIFont(name: "Helvetica Neue", size: 32.0)!,
                                                                        color: UIColor.black,
                                                                        superscriptRange: NSRange(location: text.count - 3, length: 3))
        stackView.addArrangedSubview(superscriptLabel)

        subscriptLabel.attributedText = TextFormatter.subscriptText(text: text,
                                                                    font: UIFont(name: "Helvetica Neue", size: 32.0)!,
                                                                    color: UIColor.black,
                                                                    subscriptRange: NSRange(location: text.count - 3, length: 3))
        stackView.addArrangedSubview(subscriptLabel)
        stackView.addArrangedSubview(bottomsheetButton)
        stackView.addArrangedSubview(slidingTabBarButton)
    }
    
    @objc private func launchBottomSheet() {
        let bottomSheetVC = BottomSheetController()
        bottomSheetVC.modalPresentationStyle = .fullScreen
        bottomSheetVC.closeAction = {
            bottomSheetVC.dismiss(animated: true)
        }
        present(bottomSheetVC, animated: true)
    }
    
    @objc private func launchSlidingTabBarVC() {
        showSlidingTabBarVC(show: true)
    }
    
    private func showSlidingTabBarVC(show: Bool) {
        guard let slidingTabBarVCView = self.slidingTabBarChildVC.view,
              slidingTabBarVCView.isHidden == show else {
            return
        }
        
        if show {
            slidingTabBarVCView.isHidden = false
            view.bringSubviewToFront(slidingTabBarVCView)
            UIView.animate(withDuration: 1.0, animations: {
                slidingTabBarVCView.center.y -= self.view.center.y
            }, completion: {_ in
                self.scrollView.isUserInteractionEnabled = false
            })
        } else {
            UIView.animate(withDuration: 1.0, animations: {
                slidingTabBarVCView.center.y += self.view.center.y
            }, completion: { _ in
                slidingTabBarVCView.isHidden = true
                self.view.sendSubviewToBack(slidingTabBarVCView)
                self.scrollView.isUserInteractionEnabled = true
            })
        }
    }
}
