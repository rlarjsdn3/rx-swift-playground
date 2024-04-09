import UIKit
import RxSwift

//: # range
//: 시작값(start)부터 1씩 증가하는 정수 항목을 방출하는 `Observable`을 선언합니다.

let disposeBag = DisposeBag()

Observable<Int>.range(start: 1, count: 10)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)
