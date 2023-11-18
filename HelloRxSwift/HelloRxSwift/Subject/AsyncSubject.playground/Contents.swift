import UIKit
import RxSwift

//: # ReplaySubject

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// Async Subject는 Compeleted 이벤트가 전달되는 시점에 가장 최근 이벤트를 구독자에게 방출함.
let asyncSubject = AsyncSubject<Int>()

asyncSubject
    .subscribe { print("Subscribe 1 - ", $0) }
    .disposed(by: disposeBag)

asyncSubject.onNext(10)
asyncSubject.onNext(20)
asyncSubject.onNext(30)

// Completed 이벤트가 전달되는 시점에 최근 이벤트를 구독자에게 방출함.
asyncSubject.onCompleted()
