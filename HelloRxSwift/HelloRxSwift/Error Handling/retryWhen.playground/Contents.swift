import UIKit
import RxSwift

//: # retryWhen

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let subject = PublishSubject<Int>()
let trigger = PublishSubject<Void>()

var attempts = 1

// 옵저버블이 에러 이벤트를 방출하면, 트리거 옵저버블이 Next 이벤트를 전달하면 기존 옵저버블에 대한 구독을 해제하고, 새로운 시퀀스를 구독함. (처음부터 다시 시작)
let source = Observable<Int>.create { observer in
    let currentAttempts = attempts
    print("#\(currentAttempts) START")
    
    if attempts < 3 {
        observer.onError(MyError.error)
        attempts += 1
    }
    
    observer.onNext(1)
    observer.onNext(2)
    observer.onCompleted()
    
    return Disposables.create {
        print("#\(currentAttempts) END")
    }
}

source
    .retry(when: { _ in trigger}) // 이때, 첫 시퀀스도 시도 1이라고 침.
    .subscribe { print($0) }
    .disposed(by: disposeBag)
