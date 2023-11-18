import UIKit
import RxSwift

//: # startWith

let disposeBag = DisposeBag()
let numbers = [4, 5, 6, 7, 8, 9]

// 옵저버블 시퀀스 앞에 새로운 이벤트를 추가함.
Observable<Int>.from(numbers)
    .startWith(2, 3)
    .startWith(1)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
