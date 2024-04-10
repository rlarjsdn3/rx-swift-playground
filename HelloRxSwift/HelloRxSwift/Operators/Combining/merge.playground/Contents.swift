import UIKit
import RxSwift

//: # merge
//: 여러 `Observable`을 합쳐 `next` 항목을 방출하는 연산자입니다.

let disposeBag = DisposeBag()

let odd = BehaviorSubject<Int>(value: 1)
let even = BehaviorSubject<Int>(value: 5)
let negative = BehaviorSubject<Int>(value: -7)

let observables = Observable<BehaviorSubject<Int>>.of(odd, even, negative)

observables
    .merge(maxConcurrent: 2)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)

odd.onNext(3)
odd.onNext(9)
even.onNext(6)
odd.onNext(15)
negative.onNext(-9)

odd.onCompleted()
negative.onNext(-11)
even.onNext(10)

even.onCompleted()
negative.onCompleted()
