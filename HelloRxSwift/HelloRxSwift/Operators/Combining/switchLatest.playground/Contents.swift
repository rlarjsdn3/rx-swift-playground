import UIKit
import RxSwift

//: switchLatest
//: 가장 최근에 항목을 방출한 `Observable`을 구독하는 연산자입니다. `Observable`을 항목으로 방출하는 `Observable`에 사용합니다.

let disposeBag = DisposeBag()

let first = PublishSubject<Int>()
let second = PublishSubject<Int>()

let source = PublishSubject<PublishSubject<Int>>()

source
    .switchLatest()
    .subscribe {
        print("Recevied Value: \($0)")
    }
    .disposed(by: disposeBag)

source.onNext(first)
first.onNext(1)
first.onNext(2)

source.onNext(second)
second.onNext(3)
second.onNext(4)
first.onNext(5)

first.onCompleted()
second.onCompleted()
source.onCompleted()
