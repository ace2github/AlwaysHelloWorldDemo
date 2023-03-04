//
//  HelloTableViewCell.swift
//  SwiftUIHelloWorld
//
//  Created by ChaohuiChen on 2021/7/15.
//

import UIKit
import SnapKit
import Kingfisher

class HelloTableViewCell: UITableViewCell {
    static let cellHeight: CGFloat = 100
    var titleLbl: UILabel!
    var imageV: UIImageView!
    
    static var counts: Int = 0

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLbl = UILabel.init()
        titleLbl.font = UIFont.systemFont(ofSize: 20)
        titleLbl.textColor = .black
        contentView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView).offset(10)
            make.top.equalTo(contentView).offset(10)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(20)
        }
        
        imageV = UIImageView.init()
        imageV.backgroundColor = .orange
        
        imageV.layer.masksToBounds = true
        imageV.layer.cornerRadius = 50 * 0.5
        
        contentView.addSubview(imageV)
        imageV.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView).offset(5)
            make.top.equalTo(titleLbl.snp.bottom).offset(5)
            make.size.equalTo(CGSize.init(width: 50, height: 50))
        }
    }
    
    /// 更新数据源
    func updateCell(_ data: CellDataModel?) {
        // 判空逻辑
        guard let model = data else {
            return
        }
        
        if let name = model.name {
            titleLbl.text = "name:\(name)"
        }
        
        if let age = model.age {
            if let text = titleLbl.text {
                titleLbl.text = "\(text)，age:\(age)"
            } else {
                titleLbl.text = "age:\(age)"
            }
        }
        
        // 设置头像
        if let url = model.url, let imgUrl = URL.init(string: url) {
            imageV.kf.setImage(with: .network(imgUrl))
        }
        
        self.bus("Main").emit("update", "CellUpdate")
    }
    
}
