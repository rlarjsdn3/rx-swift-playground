//
//  AlertViewModel.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/22/23.
//

import UIKit
import RxSwift
import RxCocoa

final class AlertViewModel: ViewModelType {
    struct Input { }
    
    struct Output { }
    
    let disposeBag: DisposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
}
