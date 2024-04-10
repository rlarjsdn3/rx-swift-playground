import UIKit
import RxSwift

//: # startWith
//: `Observable`이 방출하는 항목 제일 앞에 새로운 `next` 항목을 추가하는 연산자입니다.

let disposeBag = DisposeBag()

let numOfArray = Array(5...10)
Observable<Int>.from(numOfArray)
    .startWith(2, 3, 4)
    .startWith(1)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)
