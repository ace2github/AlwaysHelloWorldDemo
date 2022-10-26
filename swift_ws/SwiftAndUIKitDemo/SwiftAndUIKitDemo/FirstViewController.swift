//
//  FirstViewController.swift
//  SwiftAndUIKitDemo
//
//  Created by ChaohuiChen on 2021/12/24.
//

import UIKit

public class FirstViewController: UIViewController {
    public override func viewDidLoad() {
        self.view.backgroundColor = .lightGray
        let tapper = UITapGestureRecognizer(target: self, action: #selector(clickHandler))
        self.view.addGestureRecognizer(tapper)
    }
    
    @objc public func clickHandler() {
        self.dismiss(animated: true, completion: nil)
    }
}
