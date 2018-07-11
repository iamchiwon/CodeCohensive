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
    
    func doCalc(data: CalcData) -> CalcData {
        guard let n1 = data.n1 else { return data }
        guard let n2 = data.n2 else { return data }
        
        let result = n1 + n2
        return CalcData(n1: n1, n2: n2, result: result)
    }
    
}
