import UIKit
import RxSwift

//: # Behavior Subject
//: `BehaviorSubject`는 가장 최근에 방출한 항목을 새로운 `Observer`에게 방출하는 `Subject`입니다.


let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let subject = BehaviorSubject<Int>(value: 1)

subject
    .subscribe { print("S1 - Received Value: \($0)") }
    .disposed(by: disposeBag)

subject.onNext(2)

subject
    .subscribe { print("S2 - Received Value: \($0)") }
    .disposed(by: disposeBag)

subject.onNext(3)
subject.onNext(4)

subject.onCompleted()
