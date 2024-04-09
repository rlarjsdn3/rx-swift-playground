import UIKit
import RxSwift

//: # multicast

let disposeBag = DisposeBag()
let publishSubject = PublishSubject<Int>()

// 소스 옵저버블이 방출하는 이벤트 시퀀스를 하나 이상의 구독자가 공유하기 위해 사용함.
// Subject 타입을 파라미터로 받으며, 소스 옵져버블은 구독자가 아니라 서브젝트에 이벤트를 전달하게 됨.
// 그리고, 서브젝트는 다수의 구독자에게 이벤트를 방출함.
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(5)
    .multicast(publishSubject)
// multicast 연산자는 ConnectableObservable 타입을 반홤함.
// (유니캐스트 방식으로 동작하는 옵저버블을 멀티캐스트 방식으로 바꿔주는 거임)

source
    .subscribe { print("🔵", $0) }
    .disposed(by: disposeBag)

source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print("🔴", $0) }
    .disposed(by: disposeBag)

// 이 옵저버블은 구독자가 추가되는 시점에 시퀀스를 시작하는 게 아닌,
// connect 메서드를 직접 호출해주어야 시퀀스가 시작됨! (모든 구독자가 추가된 이후에 하나의 시퀀스를 시작하는 패턴)
source.connect()
