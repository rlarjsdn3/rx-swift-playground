import UIKit
import RxSwift

//: # scan

let disposeBag = DisposeBag()

// reduce 연산자와 동작이 동일하지만, 중간 과정의 이벤트도 방출함.
Observable<Int>.range(start: 1, count: 10)
    .scan(0) { result, next in
        var result = result
        result += next
        return result
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
