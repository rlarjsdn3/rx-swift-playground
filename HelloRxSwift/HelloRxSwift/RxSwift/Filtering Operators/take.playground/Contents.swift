import UIKit
import RxSwift

//: # take

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]

// 처음 n개의 이벤트만 방출하고, 이후 이벤트는 무시함.
Observable.from(numbers)
    .take(5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
