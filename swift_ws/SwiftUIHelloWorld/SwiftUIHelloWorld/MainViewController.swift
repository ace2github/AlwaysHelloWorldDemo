//
//  MainViewController.swift
//  SwiftUIHelloWorld
//
//  Created by ChaohuiChen on 2021/7/15.
//

import UIKit
import SnapKit

import SwiftUI


import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    let tableView: UITableView = UITableView.init()
    var dataList: Array = Array<CellDataModel>.init()
    var headerView: UIView!
    
    deinit {
        self.disposeBus("Main")
    }
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        self.bus("Main").register("update") { arg in
            print("Main recv:", arg ?? "err")
        }
        
        self.bus("Main").register("delete") { arg in
            print("Main recv:", arg ?? "err")
        }
        
        self.bus.register("MainView") { arg in
            print("recv:", arg ?? "err")
        };

        createSubviews()
        
        refreshDataSource()
        
        testJson()

        
        let btn: UIButton = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 30, y: 30, width: 100, height: 30)
        btn.backgroundColor = UIColor.white
        btn.setTitle("click", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        self.view.addSubview(btn)
        
        btn.rx.tap.subscribe(onNext: {
            print("btn click now")
        }).disposed(by: disposeBag)
        
        testRx()
        
        var count: Int = 0
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { tt in
            let arg = "val-\(count)"
            
            let action = count % 3
            switch action {
            case 0:
                self.bus.emit("MainView", arg)
            case 1:
                self.bus("Main").emit("update", "update \(arg)")
            case 2:
                self.bus("Main").emit("delete", "delete \(arg)")
            default:
                print("undefine")
            }
            
            count += 1
        }
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
