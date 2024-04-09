import UIKit
import RxSwift

//: # just
//: 단 하나의 항목을 방출하는 `Observable`을 선언합니다.

let disposeBag = DisposeBag()

Observable<[Int]>.just([1, 2, 3])
    .subscribe { print("Received Value: \($0)") }
    .disposed(by: disposeBag)
