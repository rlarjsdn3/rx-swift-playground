import UIKit
import RxSwift

//: # catchAndReturn
//: `Observable`이 `error` 항목을 방출하면 대체값 항목을 방출하는 연산자입니다.

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let subject = PublishSubject<Int>()
subject
    .catchAndReturn(-1)
    .subscribe { print("Received Value: \($0)") }
    .disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)
subject.onError(MyError.error)
