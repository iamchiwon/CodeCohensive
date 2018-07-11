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

class ViewController: UIViewController {

    @IBOutlet weak var n1Field: UITextField! // Input
    @IBOutlet weak var n2Field: UITextField! // Input
    @IBOutlet weak var resultLabel: UILabel! // Output
    @IBOutlet weak var calcButton: UIButton! // Event

    let viewModel = ViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        bindEvent()
    }

    func bindUI() {
        //n1 input
        n1Field.rx.text.map(s2i)
            .withLatestFrom(viewModel.model,
                            resultSelector: { (n1, dat) -> CalcData in
                                CalcData(n1: n1, n2: dat.n2, result: dat.result)
                            })
            .bind(to: viewModel.model)
            .disposed(by: disposeBag)

        //n2 input
        n2Field.rx.text.map(s2i)
            .withLatestFrom(viewModel.model,
                            resultSelector: { (n2, dat) -> CalcData in
                                CalcData(n1: dat.n1, n2: n2, result: dat.result)
                            })
            .bind(to: viewModel.model)
            .disposed(by: disposeBag)

        //result output
        viewModel.model.map({ $0.result })
            .map(i2s)
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }

    func bindEvent() {
        //event
        calcButton.rx.tap
            .subscribe(onNext: viewModel.doCalc)
            .disposed(by: disposeBag)

        //keyboard dismiss
        view.rx.tapped()
            .map({ $0.view })
            .drive(onNext: { $0?.endEditing(true) })
            .disposed(by: disposeBag)
    }
}

