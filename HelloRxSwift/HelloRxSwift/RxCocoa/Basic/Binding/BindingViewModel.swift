//
//  BindingViewModel.swift
//  HelloRxSwift
//
//  Created by 김건우 on 4/12/24.
//

import Foundation

import RxSwift
import RxCocoa

class BindingViewModel: ViewModelType {
    
    // MARK: - Input
    struct Input {
        var text: Observable<String>
    }
    
    // MARK: - Output
    struct Output {
        var capitalizedString: Driver<String>
    }
    
    // MARK: - Transform
    func transform(_ input: Input) -> Output {
        let capitalizedString = input.text
            .map { $0.uppercased() }
            .asDriver(onErrorJustReturn: "")
        
        return Output(capitalizedString: capitalizedString)
    }
    
}
