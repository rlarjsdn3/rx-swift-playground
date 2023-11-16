import UIKit
import RxSwift


//: # takeWhile

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]

// 조건이 true인 동안만 옵져버블이 방출하는 Next 이벤트를 받음.
// 한번이라도 false가 되면, 더 이상 조건을 검사하지 않고 이후 Next 이벤트를 쭉 무시함.
Observable.from(numbers)
    .take(while: { value in
        !value.isMultiple(of: 3)
    // ・ exclusive: 마지막으로 검사한 이벤트를 방출하지 않음.
    // ・ inclusive: 마지막으로 검사한 이벤트를 방출함.
    }, behavior: .exclusive)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
