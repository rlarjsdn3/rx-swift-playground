import UIKit
import RxSwift

//: # elementAt
//: 특정 Index에 위치한 `next` 항목만 제한적으로 방출하는 연산자입니다.

let disposeBag = DisposeBag()

let numOfArray = [1, 2, 3, 4, 5]
Observable<Int>.from(numOfArray)
    .element(at: 3)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)
