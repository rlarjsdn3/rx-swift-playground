import UIKit
import RxSwift

//: # Infallible
//: `Infalliable`은 `error` 항목을 방출할 수 없는 특별한 `Observable`입니다.

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let infalliable = Infallible<Int>.create { observer in
    observer(.next(10))
    observer(.next(20))
    
    observer(.completed)
    
    return Disposables.create()
}

infalliable
    .subscribe {
        print("Element: \($0)")
    } onCompleted: {
        print("Completed")
    } onDisposed: {
        print("Disposed")
    }
    .disposed(by: disposeBag)

