import UIKit
import RxSwift

//: # create

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

//// 옵저버블을 동작을 직접 구현함.
Observable<String>.create { observer -> Disposable in
    guard let url = URL(string: "https://www.apple.com") else {
        observer.onError(MyError.error)
        return Disposables.create()
    }
    
    guard let html = try? String(contentsOf: url, encoding: .utf8) else {
        observer.onError(MyError.error)
        return Disposables.create()
    }
    
    observer.onNext(html)
    observer.onCompleted()
    // Observable의 리소스를 정리하고 종료하는 역할을 함.
    return Disposables.create()
}
.subscribe { print($0) }
//  DisposeBag에 해당 Disposable을 추가함으로써 DisposeBag의 수명 주기에 Disposable을 연결하여 메모리 누수를 방지하고 효율적으로 리소스를 관리함.
.disposed(by: disposeBag)
