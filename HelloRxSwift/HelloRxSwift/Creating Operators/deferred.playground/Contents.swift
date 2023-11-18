import UIKit
import RxSwift

//: # deferred

let disposeBag = DisposeBag()

var flag = true
let num1 = [1, 2, 3, 4, 5]
let num2 = [6, 7, 8, 9, 10]

// 특정 조건에 따라 옵저버블을 달리 생성
let deferred = Observable<Int>.deferred {
    flag.toggle()
    
    if flag {
        return Observable.from(num1)
    } else {
        return Observable.from(num2)
    }
}

deferred
    .subscribe { print($0) }
    .disposed(by: disposeBag)

deferred
    .subscribe { print($0) }
    .disposed(by: disposeBag)
