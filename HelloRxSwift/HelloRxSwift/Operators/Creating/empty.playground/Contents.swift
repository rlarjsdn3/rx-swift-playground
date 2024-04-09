import UIKit
import RxSwift

//: # empty
//: 아무런 항목을 방출하지 않고 `Completed` 항목만 방출하는 `Observable`을 선언합니다.

let disposeBag = DisposeBag()

Observable<Void>.empty()
    .subscribe { print("Received Value: \($0)") }
    .disposed(by: disposeBag)
