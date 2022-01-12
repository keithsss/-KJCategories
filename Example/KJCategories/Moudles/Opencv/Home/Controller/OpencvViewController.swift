//
//  OpencvViewController.swift
//  KJCategories_Example
//
//  Created by 77。 on 2021/11/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//  https://github.com/YangKJ/KJCategories

import UIKit
import SnapKit

class OpencvViewController: BaseViewController {
    
    private static let opencvCellIdentifier = "opencvCellIdentifier"
    private let viewModel = OpencvViewModel()
    
    private lazy var label: UILabel = {
        let label = UILabel.init()
        label.text = "Remarks: This module needs to import the OpenCV, please execute the `pod install` operation first"
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private lazy var tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 44
        table.sectionHeaderHeight = 0.00001
        table.sectionFooterHeight = 0.00001
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.contentInsetAdjustmentBehavior = .always
        table.register(UITableViewCell.self, forCellReuseIdentifier: OpencvViewController.opencvCellIdentifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(self.label)
        self.view.addSubview(self.tableView)
        self.label.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(20)
            make.height.equalTo(40)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(0)
        }
        self.tableView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.label.snp.bottom).offset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(10)
        }
    }
}

// MARK: - UITableViewDataSource,UITableViewDelegate
extension OpencvViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dict = self.viewModel.datas[indexPath.row]
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: OpencvViewController.opencvCellIdentifier)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = UIColor.blue
        cell.textLabel?.text = "\(indexPath.row + 1). " + (dict["class"] as! String)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.textColor = UIColor.blue.withAlphaComponent(0.6)
        cell.detailTextLabel?.text = (dict["describeName"] as! String)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let className = viewModel.datas[indexPath.row]["class"] as! String
        var clazz: AnyClass? = NSClassFromString(className)
        if (clazz == nil) {// Swift classes require namespace
            let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            clazz = NSClassFromString(nameSpace + "." + className)
        }
        guard let typeClass = clazz as? BaseOpencvViewController.Type else {
            return
        }
        let vc = typeClass.init()
        vc.title = (viewModel.datas[indexPath.row]["describeName"] as! String)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
