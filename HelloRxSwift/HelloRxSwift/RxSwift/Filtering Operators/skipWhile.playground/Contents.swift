import UIKit
import RxSwift

//: # skip(while:)

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 조건이 true인 동안 옵져버블이 방출하는 Next 이벤트를 모두 무시함.
// 한번이라도 false가 되면, 더 이상 조건을 검사하지 않고 이후 Next 이벤트를 쭉 방출함.
Observable.from(numbers)
    .skip { $0 < 5 }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
