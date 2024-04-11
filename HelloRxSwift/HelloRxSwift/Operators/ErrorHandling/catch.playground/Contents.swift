import UIKit
import RxSwift

//: # catch
//: `Observable`이 `error` 항목을 방출하면 새로운 `Observable`로 대체하여 항목을 방출하는 연산자입니다.

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let subject = PublishSubject<Int>()
subject
    .catch { _ in Observable<Int>.just(-1) }
    .subscribe { print("Received Value: \($0)") }
    .disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)
subject.onError(MyError.error)
