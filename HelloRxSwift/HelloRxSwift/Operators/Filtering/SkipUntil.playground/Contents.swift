import UIKit
import RxSwift

//: # skip(until:)

let disposeBag = DisposeBag()

// 트리거 옵져버블이 Next 이벤트를 방출할 때까지, 소스 옵져버블은 이벤트를 방출하지 않고 무시함.
let subject = PublishSubject<Int>()
let trigger = PublishSubject<Void>()

subject
    .skip(until: trigger)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(10) // 무시됨.

trigger.onNext(())

subject.onNext(20)
subject.onCompleted()
