import UIKit
import RxSwift
import RxCocoa

//: # Relay
//: `Relay`는 오직 `next` 항목만 방출이 가능한 특별한 `Subject`입니다. `PublishRelay`. `BehaviorSubject`, `ReplayRelay`는 `Subject`를 래핑한 형태입니다. `Relay`는 `error`와 `completed` 항목이 방출되어선 안되는 UI 업데이트에 주로 사용됩니다.

let disposeBag = DisposeBag()

let relay = PublishRelay<Int>()
relay
    .subscribe { print("Received Value: \($0)") }
    .disposed(by: disposeBag)
relay.accept(10)
//publishRelay.onComplted() ❌
