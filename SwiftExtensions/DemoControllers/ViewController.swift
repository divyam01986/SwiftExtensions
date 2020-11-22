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
    
    private let scrollView = UIScrollView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        bottomsheetButton.addTarget(self, action: #selector(launchBottomSheet), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        layoutViews()
    }
    
    private func layoutViews() {
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
    }
    
    @objc private func launchBottomSheet() {
        let bottomSheetVC = BottomSheetController()
        bottomSheetVC.modalPresentationStyle = .fullScreen
        bottomSheetVC.closeAction = {
            bottomSheetVC.dismiss(animated: true)
        }
        present(bottomSheetVC, animated: true)
    }
}
