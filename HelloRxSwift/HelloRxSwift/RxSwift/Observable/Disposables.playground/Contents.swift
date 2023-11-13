import UIKit
import RxSwift

//: # Disposables

let disposeBag = DisposeBag()

let observable = Observable.from([1, 2, 3])
    .subscribe { value in
        print("Subscribe - ", value)
    } onError: { error in
        print("Error - ", error)
    } onCompleted: {
        print("Completed")
    } onDisposed: {
        // 구독이 해제된 후 호출됨.
        // (이 클로저에서 옵져버블이 메모리에서 해제되는 건 아님!)
        print("Disposed")
    }

// dispose를 직접 호출하는 것보다 DisposeBag을 사용하는 게 더 좋음.
// observable.dispose()
observable.disposed(by: disposeBag)
// disposedBag이라는 가방을 만들어서 뷰가 사라질 때, 한 번에 메모리에서 해제되도록 함.

// dispose를 사용하지 않으면 등록해 놓은 옵져버블이 사라지지 않아 메모리 누수가 발생함.

// 또한, dispose는 방출 중인 옵져버블을 멈추는 역할도 함.
