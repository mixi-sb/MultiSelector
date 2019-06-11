//
//  DemoViewController.swift
//  MultiSelector
//
//  Created by Meng Li on 06/10/2019.
//  Copyright (c) 2019 XFLAG. All rights reserved.
//

import UIKit
import Fakery
import MultiSelector

class DemoViewController: UIViewController {

    @IBOutlet weak var multiSelector: MultiSelector!
    
    private let faker = Faker()
    
    private lazy var allModels = (0...19).map { _ in faker.name.firstName() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        multiSelector.delegate = self
        multiSelector.models = (0..<10).map { allModels[$0] }
    }

    @IBAction func changeNumberOfModels(_ sender: UIStepper) {
        multiSelector.models = (0..<Int(sender.value)).map { allModels[$0] }
    }
    
    @IBAction func changeNumberOfColumns(_ sender: UIStepper) {
        multiSelector.numberOfColumns = Int(sender.value)
    }
    
}

extension DemoViewController: MultiSelectorDelegate {
    
    func didSelectedIndexUpdated(indexes: [Int]) {
        print(indexes.map { allModels[$0] })
    }
    
}
