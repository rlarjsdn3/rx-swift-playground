import UIKit
import RxSwift

//: share

let bag = DisposeBag()

// 앞서 배운 모든 공유 연산자를 합친 연산자임.
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .debug()
    // ・ forever: 처음 구독하는 순간부터 영원히 계속 값을 재생성하지 않고 공유된 옵저버블이 존재함을 의미함.
    // ・ whileConnected: 옵저버블에 구독이 없을 때 값을 보존하지 않고 새로운 구독이 생기면 다시 값을 생성함.
    .share(replay: 5, scope: .forever) // replay가 0이면 PublishSubject처럼 동작함. 그 외 ReplaySubject처럼 동작함.

let observer1 = source
    .subscribe { print("🔵", $0) }

let observer2 = source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print("🔴", $0) }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    observer1.dispose()
    observer2.dispose()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    let observer3 = source.subscribe { print("⚫️", $0) }
    let observer4 = source.subscribe { print("🟠", $0) }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        observer3.dispose()
        observer4.dispose()
    }
}
