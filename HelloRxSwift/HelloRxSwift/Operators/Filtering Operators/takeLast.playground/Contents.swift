import UIKit
import RxSwift

//: # takeLast

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let subject = PublishSubject<Int>()

// 옵저버블이 마지막으로 방출한 N개의 이벤트를 버퍼에 저장해두었다가,
// 옵저버블이 completed 이벤트를 방출하는 시점에 버퍼에 저장된 이벤트를 모두 방출하고, completed 이벤트를 방출함.
subject
    .takeLast(2)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(10)
subject.onNext(20)
subject.onNext(30)

// 에러 이벤트를 방출하면 버퍼에 저장된 이벤트는 모두 버려지게 되고, 에러 이벤트만 방출함.
//subject.onError(MyError.error)

subject.onCompleted()
