import UIKit
import RxSwift

//: # takeUntil

let disposeBag = DisposeBag()

let subject = PublishSubject<Int>()
let trigger = PublishSubject<Void>()

// 트리거 옵져버블이 Next 이벤트를 방출할 때까지, 소스 옵져버블은 이벤트를 방출함.
subject
    .take(until: trigger)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(10)
subject.onNext(20)

trigger.onNext(())

subject.onNext(30)
subject.onNext(50)
