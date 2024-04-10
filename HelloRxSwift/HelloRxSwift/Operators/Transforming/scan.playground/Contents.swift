import UIKit
import RxSwift

//: # scan
//: `Observable`이 방출하는 `next` 항목과 이전 항목(초기 항목)을 연산한 결과를 방출하는 연산자입니다.

let disposeBag = DisposeBag()

Observable<Int>.range(start: 1, count: 5)
    .scan(0) { return $0 + $1 }
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)
