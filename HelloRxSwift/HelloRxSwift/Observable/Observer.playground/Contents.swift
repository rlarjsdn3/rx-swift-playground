import UIKit
import RxSwift

//: # Observer
//: `Observer`는 `Observable`이 시간의 흐름에 따라 방출하는 항목을 받아 처리합니다. 일반적으로 `subscribe` 메서드로 `Observable`을 구독할 수 있습니다. `subscribe` 메서드는 내부적으로 `AnonymousObserver`를 만들어 항목을 받아들입니다.

let disposeBag = DisposeBag()

let numOfArray = Array(1...10)

Observable<Int>.from(numOfArray)
    .subscribe {
        print("Element: \($0)")
    } onCompleted: {
        print("Completed")
    } onDisposed: {
        print("Disposed")
    }
    .disposed(by: disposeBag)

