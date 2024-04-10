import UIKit
import RxSwift

//: filter
//: 클로저(조건)에 만족하는 `next` 항목만 방출하는 연산자입니다.

let disposeBag = DisposeBag()

let numOfArray = [1, 2, 3, 4, 5]
Observable<Int>.from(numOfArray)
    .filter { $0 % 2 == 0 }
    .subscribe { print("Received Value: \($0)") }
    .disposed(by: disposeBag)
