import UIKit
import EasyPeasy
class ViewController: UIViewController {
    private lazy var stackView: UIStackView = {
        let vertStackView = UIStackView()
        vertStackView.axis = .vertical
        vertStackView.spacing = 8.0
        return vertStackView
    }()
    
    private let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        layoutViews()
    }
    
    private func layoutViews() {
        view.addSubview(scrollView)
        scrollView.easy.layout(Edges(), Width(view.bounds.width))
        scrollView.addSubview(stackView)
        stackView.easy.layout(Edges())
    }
}

