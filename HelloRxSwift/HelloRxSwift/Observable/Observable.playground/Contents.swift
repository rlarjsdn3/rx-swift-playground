import UIKit
import RxSwift

//: # Observable
//: `Observable`은 하나 또는 그 이상의 `Observer`에게 시간의 흐름에 따라 항목을 방출할 수 있습니다. `Observable`은 `next`, `error`와 `completed` 항목을 방출할 수 있으며, 이 중 `error`와 `completed` 항목을 방출하면 스트림이 중단됩니다.

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let observable = Observable<Int>.create { observer in
    // next 항목 방출
    observer.on(.next(10))
    observer.onNext(20)
    
    // error 항목 방출
//    observer.onError(MyError.error)
    
    // compledted 항목 방출
    observer.onCompleted()
    
    // Observable의 리소스 해제
    return Disposables.create()
}

observable
    .subscribe { print($0) }
    .disposed(by: disposeBag)
