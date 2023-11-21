//
//  ControlEventViewModel.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class ControlEventViewModel: ViewModelType {
    struct Input {
        let redValue: Observable<Float>
        let blueValue: Observable<Float>
        let greenValue: Observable<Float>
        let resetTapped: Observable<Void>
    }
    
    struct Output {
        let redText: Driver<String>
        let blueText: Driver<String>
        let greenText: Driver<String>
        let color: Driver<UIColor>
        let reset: Driver<Float>
    }
    
    func transform(input: Input) -> Output {    
        let red = input.redValue
            .map { String(Int($0)) }
            .asDriver(onErrorJustReturn: "-")
        
        let blue = input.blueValue
            .map { String(Int($0)) }
            .asDriver(onErrorJustReturn: "-")
        
        let green = input.greenValue
            .map { String(Int($0)) }
            .asDriver(onErrorJustReturn: "-")
        
        let color = Observable.combineLatest([input.redValue, input.blueValue, input.greenValue])
            .map {
                let red = $0[0] / 255, green = $0[1] / 255, blue = $0[2] / 255
                return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
            }
            .asDriver(onErrorJustReturn: .black)
        
        let reset = input.resetTapped
            .map { Float(0) }
            .asDriver(onErrorJustReturn: Float(0))
        
        return Output(redText: red, blueText: blue, greenText: green, color: color, reset: reset)
    }
}
