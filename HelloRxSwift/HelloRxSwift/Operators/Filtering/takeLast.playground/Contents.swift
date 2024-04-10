import UIKit
import RxSwift

//: # takeLast
//: `Observable`이 방출하는 항목을 주어진 크기의 버퍼에 저장해두고, `completed` 항목을 방출하는 시점에 버퍼에 저장된 항목을 방출하는 연산자입니다.

let disposeBag = DisposeBag()

let upstream = PublishSubject<Int>()

upstream
    .takeLast(3)
    .subscribe {
        print("Recevied Value: \($0)")
    }
    .disposed(by: disposeBag)

(1...5).forEach { upstream.onNext($0) }
upstream.onCompleted()
