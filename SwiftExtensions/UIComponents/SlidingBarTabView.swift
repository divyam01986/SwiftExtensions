//
//  SlidingBarTabView.swift
//  SwiftExtensions
//
//  Created by Divya Mandyam on 3/19/21.
//

import UIKit
import EasyPeasy

class SlidingBarTabView: UIControl {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    private let slidingBar = UIView()
    
    var onTabSelected: ((Int) -> Void)?
    
    var barColor = UIColor.red {
        didSet {
            slidingBar.backgroundColor = barColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        
        addSubview(stackView)
        addSubview(slidingBar)
        
        slidingBar.backgroundColor = barColor
        slidingBar.frame = CGRect(x: bounds.origin.x,
                                  y: bounds.maxY - 1.0,
                                  width: bounds.width,
                                  height: 1.0)
        stackView.easy.layout(Top(8), Left(), Right(), Bottom(1.0))
    }
    
    
    func configure(titles: [String]) {
         titles.enumerated().forEach { (index, text) in
            let button = createButton(title: text, index: index)
            stackView.addArrangedSubview(button)
        }
        stackView.layoutIfNeeded()
    }
    
    func adjustBar(selectedIndex: Int, animate: Bool = false) {
        let selectedButton = stackView.arrangedSubviews[selectedIndex]
        let convertedOrigin = convert(CGPoint(x: selectedButton.frame.minX, y: selectedButton.frame.maxY), from: stackView) // Lower left corner of selected button
        let newFrame = CGRect(x: convertedOrigin.x,
                              y: convertedOrigin.y,
                              width: selectedButton.frame.width,
                              height: 1.0)
        if animate {
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: { [weak self] in
                            self?.slidingBar.frame = newFrame
            }, completion: nil)
        } else {
            slidingBar.frame = newFrame
        }
    }
    
    // Can override to create custom styled UIButton
    func createButton(title: String, index: Int) -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12.0)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitle(title, for: .normal)
        button.tag = index
        return button
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first?.location(in: stackView),
           let selectedIndex = stackView.arrangedSubviews.firstIndex(where: {
            return $0.frame.contains(touchPoint)
           }) {
            adjustBar(selectedIndex: selectedIndex, animate: true)
            onTabSelected?(selectedIndex)
        }
    }
}
