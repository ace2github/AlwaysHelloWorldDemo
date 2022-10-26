//
//  MainViewController.swift
//  SwiftUIHelloWorld
//
//  Created by ChaohuiChen on 2021/7/15.
//

import UIKit
import SnapKit

import SwiftUI

class MainViewController: UIViewController {
    let tableView: UITableView = UITableView.init()
    var dataList: Array = Array<CellDataModel>.init()
    var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white

        createSubviews()
        
        refreshDataSource()
    }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HelloTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(HelloTableViewCell.classForCoder())) as! HelloTableViewCell
        
        cell.selectionStyle = .none
        
        cell.updateCell(dataList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click \(indexPath.row) cell!")
    }
}

extension MainViewController {
    func createSubviews() {
        configHeaderView()
        configTableView()
    }
    
    func configHeaderView() {
        let hostPage = UIHostingController(rootView: ContentView())
        self.addChild(hostPage)
        headerView = hostPage.view
        headerView.backgroundColor = .systemOrange
    
        view.addSubview(headerView)
        headerView.snp.makeConstraints { (maker) in
            maker.top.leading.trailing.equalTo(view)
            maker.height.equalTo(150)
        }
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(UITableViewCell.classForCoder()))
        tableView.register(HelloTableViewCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(HelloTableViewCell.classForCoder()))
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.top.equalTo(headerView.snp.bottom)
            maker.bottom.leading.trailing.equalTo(view)
        }
    }
    
    func refreshDataSource() {
        for index in 0...36 {
            var model = CellDataModel.init()
            if 0 == index%2 {
                model.name = "title \(index+1)"
            } else {
                model.url = "https://t7.baidu.com/it/u=1595072465,3644073269&fm=193&f=GIF"
            }
            
            model.age = index + 6
            dataList.append(model)
        }
        tableView.reloadData()
    }
}
