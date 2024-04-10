import UIKit
import RxSwift

//: # skipUntile
//: 트리거 `Observable`이 항목을 방출할 때까지 소스 `Observable`이 방출하는 모든 항목을 무시하는 연산자입니다.

let disposeBag = DisposeBag()

let upstream = PublishSubject<Int>()
let second = PublishSubject<String>()

upstream
    .skip(until: second)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)

upstream.onNext(1)
upstream.onNext(2)
second.onNext("A")
upstream.onNext(3)
upstream.onNext(4)

upstream.onCompleted()
