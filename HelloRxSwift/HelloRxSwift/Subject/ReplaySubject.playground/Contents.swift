import UIKit
import RxSwift

//: # ReplaySubject
//: `ReplaySubject`는 버퍼 수만큼 방출한 항목을 저장해놓고, 새로운 `Observer`에게 버퍼에 저장된 항목을 방출하는 `Subject`입니다.

let disposeBag = DisposeBag()

let subject = ReplaySubject<Int>.create(bufferSize: 3)

(1...10).forEach { subject.onNext($0) }

subject
    .subscribe { print("S1 - Element: \($0)") }
    .disposed(by: disposeBag)

subject.onNext(11)

subject
    .subscribe { print("S2 - Element: \($0)") }
    .disposed(by: disposeBag)

subject.onCompleted()
