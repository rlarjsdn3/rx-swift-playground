import UIKit
import RxSwift

//: # PublishSubject

// ⭐️ Subject의 기초 이론!
// Subject는 옵져버블인 동시에, 옵저버임. 옵저버블로부터 이벤트를 전달받아, 다른 옵저버에게 이벤트를 전달해줄 수 있음.
// 각 Subject는 구독 이전에 방출된 이벤트를 어떻게 처리할 지 방식에 따른 차이고, 기본적인 메커니즘은 모두 동일함.

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// PublisheSubject는 구독 이전에 방출된 이벤트는 전달받을 수 없는 서브젝트임.
let publishSubject = PublishSubject<Int>()

publishSubject.onNext(10)

// 구독 이전에 방출된 '10'이라는 이벤트는 전달받지 못함.
publishSubject
    .subscribe { print("Subscribe 1 - ", $0) }
    .disposed(by: disposeBag)

publishSubject.onNext(20)

publishSubject
    .subscribe { print("Subscribe 2 - ", $0) }
    .disposed(by: disposeBag)

publishSubject.onNext(30)

//publishSubject.onError(MyError.error)
publishSubject.onCompleted()
// '완료' 이벤트를 방출하고 난 후, 새롭게 구독을 하게 되면 Completed 이벤트만 전달받고 끝남.
publishSubject
    .subscribe { print("Subscribe 3 - ", $0) }
    .disposed(by: disposeBag)

