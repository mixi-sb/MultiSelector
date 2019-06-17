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
    @IBOutlet weak var numberOfModelsLabel: UILabel!
    @IBOutlet weak var numberOfColumnsLabel: UILabel!
    @IBOutlet weak var numberOfSelectableItemsLabel: UILabel!
    
    private let faker = Faker()
    
    private lazy var allModels = (0...19).map { _ in faker.name.firstName() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        multiSelector.delegate = self
        multiSelector.buttonType = MultiSelectorDefaultButton.self
        multiSelector.models = (0..<10).map { allModels[$0] }
        multiSelector.pick(at: 0)
    }

    @IBAction func changeNumberOfModels(_ sender: UIStepper) {
        multiSelector.models = (0..<Int(sender.value)).map { allModels[$0] }
        numberOfModelsLabel.text = "Number of models \(multiSelector.models.count)"
    }
    
    @IBAction func changeNumberOfColumns(_ sender: UIStepper) {
        multiSelector.numberOfColumns = Int(sender.value)
        numberOfColumnsLabel.text = "Number of columns \(multiSelector.numberOfColumns)"
    }
    
    @IBAction func changeNumberOfSelectedItems(_ sender: UIStepper) {
        multiSelector.maxNumberOfSelectableItems = Int(sender.value)
        numberOfSelectableItemsLabel.text = "Max number of selectable items \(multiSelector.maxNumberOfSelectableItems)"
    }
    
}

extension DemoViewController: MultiSelectorDelegate {
    
    func didSelectedIndexUpdated(indexes: [Int]) {
        print(indexes.map { allModels[$0] })
    }
    
}
