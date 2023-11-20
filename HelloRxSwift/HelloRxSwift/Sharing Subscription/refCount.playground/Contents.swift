import UIKit
import RxSwift

//: # refCount

let disposeBag = DisposeBag()

// ConnectableObservable을 유지하면서, 새로운 구독자가 추가되는 시점에 자동으로 connect 메서드를 호출함.
// 이후, 옵저버가 구독을 중지하고, 더 이상 다른 구독자가 없다면 시퀀스를 중지함. 다시 새로운 옵저버가 추가되면 connect 메서드를 호출함.
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .debug()
    .publish()
    .refCount()

let observer1 = source
    .subscribe { print("🔵", $0) }

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    observer1.dispose()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    let observer2 = source.subscribe { print("🔴", $0) }
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        observer2.dispose()
    }
}
