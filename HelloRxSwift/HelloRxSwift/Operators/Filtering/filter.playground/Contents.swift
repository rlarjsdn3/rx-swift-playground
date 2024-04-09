import UIKit
import RxSwift

//: filter

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 특정 조건에 맞는 이벤트를 필터링해 방출함.
Observable.from(numbers)
    .filter { $0 > 5 }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
