//
//  testViewController.swift
//  SwiftTest
//
//  Created by shanbay410 on 2018/5/23.
//  Copyright © 2018年 shanbay410. All rights reserved.
//

import UIKit

let ServerName : String = "MyServer"

class CustomBtn: UIButton {
    init(frame:CGRect, name: String, target:Any, action: Selector ) {
        super.init(frame: frame)
        self.setTitle(name, for: .normal)
        self.setTitleColor(UIColor.red, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.green.cgColor
        self.addTarget(target, action: action, for: .touchUpInside)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class testViewController: UIViewController {

    let btn : CustomBtn = {
        let btn = CustomBtn(frame: CGRect(x: 20, y: 150, width: 100, height: 50), name: "点击", target: self, action: #selector(showViewController))
        return btn
    }()
    
    let btnSSkeySave : CustomBtn = {
        let btn = CustomBtn(frame: CGRect(x: 20, y: 220, width: 100, height: 50), name: "点击", target: self, action: #selector(sSKeySave))
        return btn
    }()
    
    let btnSSkeyRead : CustomBtn = {
        let btn = CustomBtn(frame: CGRect(x: 20, y: 280, width: 100, height: 50), name: "点击", target: self, action: #selector(sSKeyRead))
        return btn
    }()
    
    let indicatorLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 150, y: 220, width: 300, height: 50))
        label.textColor = UIColor.black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ConfigUI()
    }
    
    func ConfigUI() -> Void {
        self.view.addSubview(self.btn)
        self.view.addSubview(self.btnSSkeySave)
        self.view.addSubview(self.btnSSkeyRead)
        self.view.addSubview(self.indicatorLabel)
    }
    
}
extension testViewController{
    @objc func showViewController() -> Void {
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func sSKeySave() -> Void {
        //先存储
        let isSuccess : Bool = SSkeyChainTesst.storeYourPassword("TestOne")
        if isSuccess {
            self.indicatorLabel.text = "Save Success"
        }else{
            self.indicatorLabel.text = "Save Error"
        }
    }
    
    @objc func sSKeyRead() -> Void {
        //读取
        let password = SSkeyChainTesst.readYourpassword()
        if let pass = password {
            self.indicatorLabel.text = "Password : " + pass
        }else{
            self.indicatorLabel.text = "Read Error"
        }
    }
}
