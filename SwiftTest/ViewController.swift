//
//  ViewController.swift
//  SwiftTest
//
//  Created by shanbay410 on 2018/5/22.
//  Copyright © 2018年 shanbay410. All rights reserved.
//

import UIKit

enum OnOffSwitch {
    case On,Off
    mutating func togg() { //改变实例的值
        switch self{
        case .Off:
            self = .On
        case .On:
            self = .Off
        }
    }
}

protocol testPro {
    init(ip: String)
}

class testClass: testPro {
    required init(ip: String) {
        print("Test")
    }
    
}




class ViewController: UIViewController {
    
    lazy var statsView : UIView = {
        let view = UIView.init(frame: CGRect.init(x: 10, y: 140, width: 100, height: 50))
        view.backgroundColor = UIColor.red
        return view
    }()
    
    //map函数里面可以直接使用函数作为参数,这里采用函数的方式。
    let numberArray = [1,2,3,4,5]
    
    func fmap(a : Int) -> Int{
        return a + 10
    }
    
    func gmap(a : Int) -> Int{
        if a > 2 {
            return a
        }else{
            return 1
        }
    }
    func isOushu(a : Int) -> Bool {
        if a % 2 == 1 {
            return true
        }else{
            return false
        }
    }
    
    func sumTest(a : Int , b : Int) -> Int {
        return a * b
    }
    let test = TestWillAndDid(name: "Yang")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var lightSwitch = OnOffSwitch.Off
        lightSwitch.togg()
        print(lightSwitch)
        
        var odds = [Int]()
        odds = Array(1...10).filter(isOushu)
        print(odds)
        
        let testNil = [12,"yang",1] as [Any]
        print(testNil)
        
        let result = numberArray.map(fmap)
        print(result)
        
        let result1 = numberArray.map(gmap)
        print(result1)
        
        let result2 = numberArray.map({"\($0)只"})
        print(result2)
        
        let result3 = numberArray.reduce(1,sumTest)
        print(result3)
        
        if self.isPrime(number: 102){
            print("Yes")
        }else{
            print("No")
        }
        
        test.addObserver(self, forKeyPath: "name", options: .new, context: nil)
        test.name = "Yu"
        
        self.view.addSubview(self.statsView)
        
        self.loadDate { [weak self] in
            self?.view.backgroundColor = UIColor.green
        }
       
        
    }
    
    deinit {
        print("deinit")
        test.removeObserver(self, forKeyPath: "name")
    }
}

class TestWillAndDid : NSObject {
    @objc dynamic var name : String {
        willSet{
            print("The new value is \(newValue)")
        }
        didSet{
            print("The old value is \(oldValue)")
        }
    }
    init(name : String) {
        self.name = name
    }
}

extension ViewController{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "name" {
            print("我懂了")
        }
    }
    // 第一步： 定义尾随闭包
    func loadDate (completion:@escaping ()->()) -> () {
        // 异步执行
        DispatchQueue.global().async {
            print("这是耗时操作")
            DispatchQueue.main.async {
                // 回调闭包
                completion()
            }
        }
    }
    
    func loadDate1(completion : @escaping ()->()) -> () {
        DispatchQueue.global().async {
            print("这是耗时操作")
            DispatchQueue.main.async {
                // 回调闭包
                completion()
            }
        }
    }
    
    func loadData(comlpant: @escaping (_ resoult: [String]) -> ()) -> () {
        // 将任务添加到队列，指定执行人的函数（闭包） 以同步/异步 执行
        
        DispatchQueue.global().async {
            print("耗时操作\(Thread.current)")
            // 消耗时间
            Thread.sleep(forTimeInterval: 1)
            let json = ["affas","afdasf","fd"]
            // 主队列回调
            DispatchQueue.main.async {
                print("主线程更新UI\(Thread.current)")
                // 闭包回调
                comlpant(json)
            }
        }
    }
}

extension ViewController{
    func isFactor(number: Int, potential: Int) -> Bool {
        return (number % potential) == 0
    }
    
    func factors(number: Int) -> [Int] {
        return Array(1...number).filter {
            isFactor(number: number, potential: $0)}
    }
    
    func sumFactors(number: Int) -> Int {
        return factors(number: number).reduce(0){ (total, num) in
            total + num }
    }
    
    func isPrime(number: Int) -> Bool {
        return sumFactors(number: number) == number + 1
    }
}



