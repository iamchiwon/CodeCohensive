//
//  Extensions.swift
//  CodeCohensive
//
//  Created by iamchiwon on 2018. 7. 11..
//  Copyright © 2018년 ncode. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    
    public func tapped(count: Int = 1) -> Driver<UITapGestureRecognizer> {
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.numberOfTapsRequired = count
        
        base.isUserInteractionEnabled = true
        base.addGestureRecognizer(tapGestureRecognizer)
        
        return tapGestureRecognizer.rx.event.asDriver()
    }
}
