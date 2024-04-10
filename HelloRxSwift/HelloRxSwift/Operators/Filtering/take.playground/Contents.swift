import UIKit
import RxSwift

//: # take
//: 일정 횟수만큼 `next` 항목을 받고, 이후 항목을 무시하는 연산자입니다.

let disposeBag = DisposeBag()

let numOfArray = Array(1...10)
Observable<Int>.from(numOfArray)
    .take(2)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)
