//
//  ButtonViewController.swift
//  KJCategories_Example
//
//  Created by 77。 on 2021/11/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//  https://github.com/YangKJ/KJCategories

import UIKit
import SnapKit
import KJCategories

class ButtonViewController: BaseViewController {

    private lazy var layoutButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.init(named: "wode_nor"), for: .normal)
        button.setTitle("Center", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.kj_contentLayout(.centerImageTop, padding: 10)
        button.enlargeClick = 20
        button.kj_addAction { button in
            let style = KJButtonContentLayoutStyle(rawValue: Int(arc4random() % 7))
            button.kj_contentLayout(style ?? .centerImageTop, padding: 10)
        }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.updateFrame()
    }
    
    func setupUI() {
        self.view.addSubview(self.layoutButton)
        self.layoutButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(self.view)
            make.width.equalTo(AdaptLevel(220))
            make.height.equalTo(self.layoutButton.snp.width).multipliedBy(0.5)
        }
    }
    
    func updateFrame() {
        self.layoutButton.kj_updateFrame()
        layoutButton.bezierBorder(withRadius: 10, borderWidth: 2, borderColor: UIColor.blue)
    }
}
