import UIKit
import RxSwift

//: # from
//: 배열 요소를 하나씩 항목으로 방출하는 `Observable`을 선언합니다.

let disposeBag = DisposeBag()

let numOfArray = [1, 2, 3, 4, 5]
Observable<Int>.from(numOfArray)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)


