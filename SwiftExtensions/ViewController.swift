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
    
    private let scrollView = UIScrollView()
    
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
                                                                        font: UIFont(name: "Helvetica Neue", size: 16.0)!,
                                                                        color: UIColor.black, superscriptRange: NSRange(location: text.count - 3, length: 3))
        stackView.addArrangedSubview(superscriptLabel)
        
        subscriptLabel.attributedText = TextFormatter.subscriptText(text: text,
                                                                    font: UIFont(name: "Helvetica Neue", size: 16.0)!,
                                                                    color: UIColor.black,
                                                                    subscriptRange: NSRange(location: text.count - 3, length: 3))
        stackView.addArrangedSubview(subscriptLabel)
    }
}

