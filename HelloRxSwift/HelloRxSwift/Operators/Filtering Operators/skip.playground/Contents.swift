import UIKit
import RxSwift

//: # skip

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 옵저버블에서 정해진 숫자 만큼 방출되는 이벤트를 생략하고, 이후 이벤트를 방출함.
Observable.from(numbers)
    .skip(3)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
