import UIKit
import RxSwift

//: # reduce

let disposeBag = DisposeBag()


// scan 연산자와는 달리, 최종 결과 이벤트만 방출함.
Observable<Int>.range(start: 1, count: 5)
    .reduce(0) { result, next in
        var result = result
        result += next
        return result
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
