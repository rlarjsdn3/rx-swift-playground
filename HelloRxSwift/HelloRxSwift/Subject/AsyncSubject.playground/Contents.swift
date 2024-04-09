import UIKit
import RxSwift

//: # AsyncSubject
//: `AsyncSubject`는 `Completed` 항목을 방출하는 시점에 가장 최근에 방출한 항목을 `Observer`에게 방출하는 `Subject`입니다.

let disposeBag = DisposeBag()

let subject = AsyncSubject<Int>()

subject
    .subscribe { print("Element: \($0)") }
    .disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)

subject.onCompleted()
