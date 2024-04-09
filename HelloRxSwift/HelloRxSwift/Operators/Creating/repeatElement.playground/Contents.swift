import UIKit
import RxSwift

//: # repeatElment
//: 동일한 항목을 무한정 방출하는 `Observable`을 선언합니다.

let disposeBag = DisposeBag()

Observable.repeatElement("⭐️")
    .take(10)
    .subscribe { print("Received Value: \($0)") }
    .disposed(by: disposeBag)
