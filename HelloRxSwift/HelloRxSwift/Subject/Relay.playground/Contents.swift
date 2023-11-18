import UIKit
import RxSwift
import RxCocoa

//: # Relay

let bag = DisposeBag()

// ⭐️ Relay의 기초 이론!
// Relay는 Completed와 Error 이벤트 방출이 불가능한, 오직 Next 이벤트만 방출가능한 특별한 Subject임.
// PublishRelay, BehaviorRelay와 ReplayRelay는 각 Subject를 래핑한 형태임. 각 Relay의 특성은 각 Subject의 특성과 동일함.
// Relay는 RxCocoa에 정의되어 있음. 이런 특성으로 터치 이벤트와 같은 UI 이벤트를 처리할 때 주로 사용함. (UI 이벤트는 끝이 없으므로)

let disposeBag = DisposeBag()

// PublishRelay
let publishRelay = PublishRelay<Int>()
publishRelay
    .subscribe { print("PublishRelay - ", $0) }
    .disposed(by: bag)
publishRelay.accept(10) // on, onNext 메서드가 아닌 accept 메서드를 대신 사용함.
//publishRelay.onComplted() ❌


// BehaviorRelay
let behaviorRelay = BehaviorRelay<Int>(value: 10)
behaviorRelay
    .subscribe { print("BehaviorRelay - ", $0) }
    .disposed(by: bag)
behaviorRelay.accept(20)
//behaviorRelay.onCompleted() ❌


// ReplayRelay
let replayRelay = ReplayRelay<Int>.create(bufferSize: 3)
replayRelay
    .subscribe { print("ReplayRelay 1 - ", $0) }
    .disposed(by: disposeBag)
(1...10).forEach { replayRelay.accept($0)
}
replayRelay
    .subscribe { print("ReplayRelay 2 - ", $0) }
    .disposed(by: disposeBag)

