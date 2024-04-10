import UIKit
import RxSwift

//: # takeWhile
//: 클로저(조건)가 true를 반환하는 동안 `Observable`이 방출하는 모든 항목을 전달받는 연산자입니다. 한번이라도 false를 반환하면 더 이상 조건을 검사하지 않고 모든 `next` 항목을 무시합니다.

let disposeBag = DisposeBag()

let numOfArray = Array(1...10)
Observable<Int>.from(numOfArray)
    .take(while: {
        $0 < 5
    // inclusive: 마지막으로 검사한 항목 방출O
    // exclusive: 마지막으로 검사한 항목 방출X
    }, behavior: .exclusive)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)
