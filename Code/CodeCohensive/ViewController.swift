//
//  ViewController.swift
//  CodeCohensive
//
//  Created by iamchiwon on 2018. 7. 10..
//  Copyright © 2018년 ncode. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController // <==

// Common Functions
let intToText = { (i: Int) in "\(i)" }
///

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

class Context {

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

let i2s = { (i: Int?) in "\(i ?? 0)" }
let s2i = { (s: String?) in Int(s ?? "0") }

class ViewController: UIViewController {

    @IBOutlet weak var n1Field: UITextField! // Input
    @IBOutlet weak var n2Field: UITextField! // Input
    @IBOutlet weak var resultLabel: UILabel! // Output
    @IBOutlet weak var calcButton: UIButton! // Event

    let context = Context()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        bindEvent()
    }

    func bindUI() {
        //n1 input
        n1Field.rx.text.map(s2i)
            .withLatestFrom(context.model,
                            resultSelector: { (n1, dat) -> CalcData in
                                CalcData(n1: n1, n2: dat.n2, result: dat.result)
                            })
            .bind(to: context.model)
            .disposed(by: disposeBag)

        //n2 input
        n2Field.rx.text.map(s2i)
            .withLatestFrom(context.model,
                            resultSelector: { (n2, dat) -> CalcData in
                                CalcData(n1: dat.n1, n2: n2, result: dat.result)
                            })
            .bind(to: context.model)
            .disposed(by: disposeBag)

        //result output
        context.model.map({ $0.result })
            .map(i2s)
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }

    func bindEvent() {
        //event
        calcButton.rx.tap
            .subscribe(onNext: context.doCalc)
            .disposed(by: disposeBag)
    }
}

