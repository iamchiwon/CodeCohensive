//
//  Model.swift
//  CodeCohensive
//
//  Created by iamchiwon on 2018. 7. 11..
//  Copyright © 2018년 ncode. All rights reserved.
//

import Foundation

struct CalcData {
    let n1: Int?
    let n2: Int?
    let result: Int?
}

extension CalcData {
    static func empty() -> CalcData {
        return CalcData(n1: nil, n2: nil, result: nil)
    }
}
