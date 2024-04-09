import UIKit
import RxSwift

//: # of
//: 가변 매개변수로 전달한 항목을 차례대로 방출하는 `Observable`을 선언합니다.

let disposeBag = DisposeBag()

Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)
