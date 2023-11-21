//
//  CollectionViewModel.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import RxSwift
import RxCocoa

final class CollectionViewModel: ViewModelType {
    let colors: BehaviorRelay<[UIColor]> = BehaviorRelay<[UIColor]>(value: MaterialBlue.allColors)
    
    struct Input {
        let itemTapped: Observable<UIColor>
    }
    
    struct Output { }
    
    let disposeBag: DisposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        input.itemTapped
            .subscribe { print("선택된 아이템 - \($0.element?.rgbHexString ?? "-")") }
            .disposed(by: disposeBag)
        
        return Output()
    }
}
