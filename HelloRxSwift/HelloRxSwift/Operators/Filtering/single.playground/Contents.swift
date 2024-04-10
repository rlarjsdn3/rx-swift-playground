import UIKit
import RxSwift

//: # single
//: `Observable`이 단 하나의 `next` 항목만 방출하도록 하는 연산자입니다. 추가로 항목을 방출하면 `error` 항목을 방출합니다.

let disposeBag = DisposeBag()

let numOfArray = Array(1...3)
Observable<[Int]>.just(numOfArray)
    .single()
    .subscribe {
        print("S1 - Received Value: \($0)")
    }
    .disposed(by: disposeBag)

Observable<Int>.from(numOfArray)
    .single()
    .subscribe {
        print("S2 - Received Value: \($0)")
    }
    .disposed(by: disposeBag)
