//
//  MultiSelector.swift
//  MultiSelector
//
//  Created by Meng Li on 2019/06/10.
//  Copyright © 2018 XFLAG. All rights reserved.
//

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

public class MultiSelector: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = verticalSpaceing
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var buttons: [UIButton] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func refresh() {
        buttons.forEach { $0.removeFromSuperview() }
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        buttons.reduce([[]]) {
            if $0.count == 0 {
                return [[$1]]
            }
            var result = $0
            var lastArray = result[result.count - 1]
            if lastArray.count == numberOfColumns {
                result.append([$1])
                return result
            }
            lastArray.append($1)
            result[result.count - 1] = lastArray
            return result
        }.map { (buttons: [UIButton]) -> UIStackView in
            let subStackView = UIStackView()
            subStackView.axis = .horizontal
            subStackView.spacing = horizontalSpacing
            subStackView.distribution = .fillEqually
            buttons.forEach {
                subStackView.addArrangedSubview($0)
            }
            if buttons.count < numberOfColumns {
                (buttons.count..<numberOfColumns).forEach { _ in
                    subStackView.addArrangedSubview(UIView())
                }
            }
            return subStackView
        }.forEach {
            stackView.addArrangedSubview($0)
        }

    }
    
    @IBInspectable
    public var numberOfColumns: Int = 4 {
        didSet {
            refresh()
        }
    }
    
    @IBInspectable
    public var verticalSpaceing: CGFloat = 10 {
        didSet {
            stackView.spacing = verticalSpaceing
        }
    }
    
    @IBInspectable
    public var horizontalSpacing: CGFloat = 10 {
        didSet {
            stackView.arrangedSubviews.map {
                $0 as? UIStackView
            }.forEach {
                $0?.spacing = horizontalSpacing
            }
        }
    }
    
    public var models: [String] = [] {
        didSet {
            buttons = models.map {
                let button = UIButton()
                button.setTitle($0, for: .normal)
                button.backgroundColor = .lightGray
                return button
            }
            refresh()
        }
    }
    
}
