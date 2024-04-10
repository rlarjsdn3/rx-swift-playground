import UIKit
import RxSwift

//: # skip
//: 일정 횟수만큼 `next` 항목을 무시하고, 이후 항목을 방출하는 연산자입니다.

let disposeBag = DisposeBag()

let numOfArray = Array(1...10)
Observable<Int>.from(numOfArray)
    .skip(3)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)
