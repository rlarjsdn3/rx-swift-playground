//
//  ControlEventViewModel.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit

import RxSwift
import RxCocoa

final class TraitsViewModel: ViewModelType {
    struct Input {
        let red: Observable<Float>
        let blue: Observable<Float>
        let green: Observable<Float>
        let didTapResetButton: Observable<Void>
    }
    
    struct Output {
        let redText: Driver<String>
        let blueText: Driver<String>
        let greenText: Driver<String>
        let color: Driver<UIColor>
        let shouldResetColor: Driver<Float>
    }
    
    func transform(_ input: Input) -> Output {    
        let red = input.red
            .map { String(format: "%.0f", $0) }
            .asDriver(onErrorJustReturn: "-")
        
        let blue = input.blue
            .map { String(format: "%.0f", $0) }
            .asDriver(onErrorJustReturn: "-")
        
        let green = input.green
            .map { String(format: "%.0f", $0) }
            .asDriver(onErrorJustReturn: "-")
        
        let color = Observable.combineLatest(
            [input.red, input.blue, input.green]
        )
        .map { UIColor(red: $0[0], green: $0[1], blue: $0[2], alpha: 1.0) }
        .asDriver(onErrorJustReturn: UIColor.black)
        
        let reset = input.didTapResetButton
            .map { Float(0) }
            .asDriver(onErrorJustReturn: 0)
        
        return Output(redText: red, blueText: blue, greenText: green, color: color, shouldResetColor: reset)
    }
}
