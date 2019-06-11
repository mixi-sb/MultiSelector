//
//  RxDemoViewController.swift
//  MultiSelector_Example
//
//  Created by Meng Li on 2019/06/11.
//  Copyright © 2019 XFLAG. All rights reserved.
//

import Fakery
import MultiSelector
import RxSwift
import SnapKit
import UIKit

class RxDemoViewController: UIViewController {
    
    private let faker = Faker()
    private let disposeBag = DisposeBag()
    
    private lazy var allModels = (0..<10).map { _ in faker.name.firstName() }
    
    private lazy var multiSelector: MultiSelector = {
        let multiSelector = MultiSelector()
        multiSelector.models = allModels
        multiSelector.rx.indexesSelected.subscribe(onNext: { [unowned self] in
            print($0.map { self.allModels[$0] })
        }).disposed(by: disposeBag)
        return multiSelector
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(multiSelector)
        
        multiSelector.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(120)
        }
    }
    
}
