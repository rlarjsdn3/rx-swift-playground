import UIKit
import RxSwift

//: # catchAndReturn

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let subject = PublishSubject<Int>()
let recovery = PublishSubject<Int>()

// 옵저버블에서 에러 이벤트를 방출하면 구독이 종료되고, 옵저버는 새로운 이벤트를 전달받지 못하게 됨.
// 에러 이벤트가 방출된다면, 그대로 방출하지 않고, 새로운 옵저버블을 만들거나(catch), 기본 값을 방출(catchAndReturn)함.
subject
    .catchAndReturn(777)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(10)
subject.onNext(20)
subject.onNext(30)

subject.onError(MyError.error)
