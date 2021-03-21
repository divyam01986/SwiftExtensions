//
//  SlidingTabBarVC.swift
//  SwiftExtensions
//
//  Created by Divya Mandyam on 3/21/21.
//

import UIKit
import EasyPeasy
class SlidingTabBarVC: UIViewController {
    private let slidingTabBarView = SlidingBarTabView()
    private let tableView = UITableView()
    
    private let closeButton = UIButton(type: .close)
    
    private var selectedIndex = 0
    
    var onClose = {}

    private let tabTitles: [String]
    
    
    init(tabTitles: [String]) {
        self.tabTitles = tabTitles
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layoutViews()
    }
    
    private func setup() {
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        
        slidingTabBarView.onTabSelected = { [weak self] selectedIndex in
            self?.selectedIndex = selectedIndex
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        slidingTabBarView.adjustBar(selectedIndex: selectedIndex)
    }
    
    private func layoutViews() {
        view.backgroundColor = UIColor.clear
        view.addSubview(closeButton)
        closeButton.easy.layout(CenterX(), Width(45), Height(45), Top())
        
        view.addSubview(slidingTabBarView)
        slidingTabBarView.easy.layout(Top(4).to(closeButton, .bottom), Left(), Right())
        slidingTabBarView.configure(titles: ["Left Option", "Middle Option", "Right Option"])
        slidingTabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        slidingTabBarView.layer.cornerRadius = 3.0
        slidingTabBarView.layer.masksToBounds = true
        
        view.addSubview(tableView)
        tableView.easy.layout(Top().to(slidingTabBarView,.bottom), Left(), Right(), Bottom())
    }
    
    @objc private func closeButtonPressed() {
        onClose()
    }
}
