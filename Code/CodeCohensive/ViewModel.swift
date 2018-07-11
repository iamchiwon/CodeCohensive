//
//  ViewModel.swift
//  CodeCohensive
//
//  Created by iamchiwon on 2018. 7. 11..
//  Copyright © 2018년 ncode. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    
    let model = BehaviorRelay<CalcData>(value: CalcData.empty())
    
    func doCalc(sender: Any) {
        let m = model.value
        guard let n1 = m.n1 else { return }
        guard let n2 = m.n2 else { return }
        
        let result = n1 + n2
        let r = CalcData(n1: m.n1, n2: m.n2, result: result)
        model.accept(r)
    }
    
}
