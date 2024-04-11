import UIKit
import RxSwift

//: amb
//: 가장 처음으로 항목을 방출한 `Observable`을 구독하는 연산자입니다.

let disposeBag = DisposeBag()

let first = PublishSubject<Int>()
let second = PublishSubject<Int>()

Observable<Int>.amb([first, second])
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)

second.onNext(1)
first.onNext(2)
second.onNext(3)

second.onCompleted()
