import UIKit
import RxSwift

//: # Infallible

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// 에러를 방출할 수 없는 Infallible 시퀀스 생성
let infalliable = Infallible<Int>.create { observer in
    // Infallible 시퀀스에서는 아래 두 메서드 사용 불가
    // observer.on(.next(10))
    // observer.onNext(20)
    
    // 대산 아래 구문으로 이벤트를 방출해야 함.
    observer(.next(10))
    observer(.next(20))
    observer(.completed)
    
    return Disposables.create()
}

infalliable
    .subscribe { print($0) }
    .disposed(by: disposeBag)
