import UIKit
import RxSwift

//: # map
//: 소스 `Observable`이 방출하는 `next` 항목을 대상으로 클로저를 실행해 변환된 항목을 방출하도록 하는 연산자입니다.

let disposeBag = DisposeBag()

let numOfArray = Array(1...10)
Observable<Int>.from(numOfArray)
    .map { pow(Decimal($0), 2) }
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)
