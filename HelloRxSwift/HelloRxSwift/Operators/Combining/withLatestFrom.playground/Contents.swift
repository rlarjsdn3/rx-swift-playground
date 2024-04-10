import UIKit
import RxSwift

//: # withLatestFrom
//: 소스 `Observable`은 트리거 `Observable`이 항목을 방출할 때, 최근 방출한 항목을 전달하는 연산자입니다.

let disposeBag = DisposeBag()

let subject = PublishSubject<String>()
let trigger = PublishSubject<Void>()

trigger.withLatestFrom(subject) { "Hello, \($1)" }
.subscribe { print("Received Value: \($0)") }
.disposed(by: disposeBag)

subject.onNext("Swift")
subject.onNext("RxSwift")
trigger.onNext(())

subject.onNext("C++")
trigger.onNext(())
trigger.onNext(())

trigger.onCompleted()
