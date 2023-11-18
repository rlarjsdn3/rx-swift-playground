import UIKit
import RxSwift

//: # Behavior Subject

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// Behavior Subject는 최근 이벤트와 함께 새로운 구독자에게 이벤트를 방출하는 서브젝트임.
let behaviorSubject = BehaviorSubject<Int>(value: 10)

behaviorSubject
    .subscribe { print("Subscribe 1 - ", $0) }
    .disposed(by: disposeBag)

behaviorSubject.onNext(20)

behaviorSubject
    .subscribe { print("Subscribe 2 - ", $0) }
    .disposed(by: disposeBag)

behaviorSubject.onNext(30)

//behaviorSubject.onError(MyError.error)
behaviorSubject.onCompleted()
