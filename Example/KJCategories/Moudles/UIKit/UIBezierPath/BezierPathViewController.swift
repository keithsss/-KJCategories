//
//  BezierPathViewController.swift
//  KJCategories_Example
//
//  Created by yangkejun on 2021/11/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//  https://github.com/YangKJ/KJCategories

import UIKit
import SnapKit
import KJCategories

class BezierPathViewController: BaseViewController {

    private lazy var label: UILabel = {
        let label = UILabel.init()
        label.text = "Curve after rounding."
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.green
        label.textAlignment = .center
        return label
    }()
    
    private lazy var bezierView: BezierPathView = {
        let view = BezierPathView.init(frame: .zero)
        view.backgroundColor = UIColor.green.withAlphaComponent(0.2)
        return view
    }()
    
    private lazy var bottomBezierView: BezierPathView = {
        let view = BezierPathView.init(frame: .zero)
        view.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        return view
    }()
    
    private lazy var datas: [String : Int] = {
        let datas = [
            "10" : 100,
            "29" : 50,
            "56" : 223,
            "99" : 134,
            "192" : 212,
            "254" : 99,
            "278" : 278,
        ]
        return datas
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setDatas()
    }
    
    func setupUI() {
        self.view.addSubview(self.label)
        self.view.addSubview(self.bezierView)
        self.view.addSubview(self.bottomBezierView)
        self.bezierView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            make.left.right.equalTo(self.view).inset(30)
            make.height.equalTo(self.bottomBezierView.snp.height)
        }
        self.bottomBezierView.snp.makeConstraints { make in
            make.top.equalTo(self.bezierView.snp.bottom).offset(50)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(30)
            make.left.right.equalTo(self.view).inset(30)
            make.height.equalTo(self.bezierView.snp.height)
        }
        self.label.snp.makeConstraints { make in
            make.top.equalTo(self.bezierView)
            make.left.right.equalTo(self.view).inset(30)
            make.bottom.equalTo(self.bottomBezierView)
        }
    }
    
    func setDatas() {
        self.bezierView.kj_updateFrame()
        let height: Int = Int(self.bezierView.frame.size.height) - 50
        let width: Int = Int(self.bezierView.frame.size.width)
        let path = UIBezierPath.init()
        let keys = self.datas.keys.sorted { Int($0)! < Int($1)! }//self.datas.keys.sorted(by: <)
        keys.enumerated().forEach { (index, element) in
            let point = CGPoint(x: Int(element)!, y: height - self.datas[element]!)
            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.addLine(to: CGPoint(x: width-10, y: 100))
        let smoothedPath = path.kj_smoothedPath(withGranularity: 25)
        self.bezierView.shapeLayer.path = path.cgPath
        self.bottomBezierView.shapeLayer.path = smoothedPath.cgPath
        
        self.datas.enumerated().forEach { (index, element) in
            print("x:\(Int(element.key)!), y:\((element).value)")
        }
        print("-------------------------------------------")
        for value in smoothedPath.points {
            let point: CGPoint = (value as AnyObject).cgPointValue
            print("x:\(point.x), y:\(point.y)")
        }
    }
}
