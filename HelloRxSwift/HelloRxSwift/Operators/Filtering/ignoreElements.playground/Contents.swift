import UIKit
import RxSwift

//: # ignoreElements
//: `Observable`이 방출하는 모든 `next` 항목을 무시하는 연산자입니다.


let disposeBag = DisposeBag()

let numOfArray = Array(1...10)
Observable<Int>.from(numOfArray)
    .ignoreElements()
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)
