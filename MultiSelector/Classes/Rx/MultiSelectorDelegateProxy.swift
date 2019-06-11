//
//  MultiSelectorDelegateProxy.swift
//  MultiSelector
//
//  Created by Meng Li on 2019/06/11.
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

import RxSwift
import RxCocoa

extension MultiSelector: HasDelegate {
    public typealias Delegate = MultiSelectorDelegate
}

class RxMultiSelectorDelegateProxy: DelegateProxy<MultiSelector, MultiSelectorDelegate>, DelegateProxyType, MultiSelectorDelegate {
    
    let (didSelectedIndexUpdatedSubject, didSelectedIndexUpdated): (PublishSubject<[Int]>, ControlEvent<[Int]>) = {
        let subject = PublishSubject<[Int]>()
        return (subject, ControlEvent<[Int]>(events: subject.asObserver()))
    }()
    
    // MARK:- DelegateProxyType
    static func registerKnownImplementations() {
        self.register { (parent) -> RxMultiSelectorDelegateProxy in
            return RxMultiSelectorDelegateProxy(parentObject: parent, delegateProxy: RxMultiSelectorDelegateProxy.self)
        }
    }
    
    static var identifier: UnsafeRawPointer {
        let objectIdentifier = ObjectIdentifier(MultiSelector.self)
        let integerIdentifier = Int(bitPattern: objectIdentifier)
        return UnsafeRawPointer(bitPattern: integerIdentifier)!
    }
    
    // MARK:- InfinitePickerDelegate
    func didSelectedIndexUpdated(indexes: [Int]) {
        didSelectedIndexUpdatedSubject.onNext(indexes)
    }
    
}
