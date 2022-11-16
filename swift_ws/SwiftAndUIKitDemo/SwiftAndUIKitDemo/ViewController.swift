//
//  ViewController.swift
//  SwiftAndUIKitDemo
//
//  Created by ChaohuiChen on 2021/12/24.
//

import UIKit
import Foundation

import SnapKit
import Kingfisher
import FMDB

protocol AnyProtocol:AnyObject {
}
extension AnyProtocol {
    func addNewFeature(name:String) {
        print("add new feature, name \(name)")
    }
}
extension NSObject : AnyProtocol {}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    
    func findMin<T: Comparable>(_ a: T, _ b: T) -> T {
        return a > b ? b : a
    }
    
    
    let titleLbl:UILabel = UILabel()
    let tableView = UITableView(frame: .zero, style: .plain)
    let imageV = UIImageView()
    let button = UIButton(type: .custom)
    
    struct InnerState {
        var State: Int = 0
    }
    
    fileprivate var mutableState = InnerState()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findMin(10, 1)
        //let db = FMDatabase(path: "");
        
        // Do any additional setup after loading the view.
        //self.view.backgroundColor = UIColor.blue

        self.view.addSubview(self.imageV)
        self.imageV.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.top.leading.equalTo(self.view).offset(30)
        }
        
        self.button.setTitle("press", for: .normal)
        self.button.setTitleColor(.orange, for: .normal)
        self.button.layer.cornerRadius = 6.0;
        self.button.addAction(UIAction.init(handler: { (action) in
            print("button press now!")
            let firstVC = FirstViewController()
            self.present(firstVC, animated: true, completion: nil)
        }), for: .touchUpInside)
        
        self.view.addSubview(self.button)
        self.button.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.centerY.equalTo(self.imageV.snp.centerY);
            make.leading.equalTo(self.imageV.snp.trailing)
        }
        
        self.titleLbl.text = "HelloWorld"
        self.titleLbl.textColor = .orange
        self.titleLbl.textAlignment = .center;
        self.view.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(100)
            make.leading.trailing.equalTo(self.view)
            make.height.equalTo(30)
        }
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "default")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(self.titleLbl.snp.bottom)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        self.addNewFeature(name: "hui")
        self.tableView.addNewFeature(name: "tbl")

        
        let url = URL(string: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png")
        self.imageV.kf.setImage(with: url)
    }

}

