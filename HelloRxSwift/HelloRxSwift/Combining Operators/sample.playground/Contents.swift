import UIKit
import RxSwift

//: # sample

let disposeBag = DisposeBag()

let trigger = PublishSubject<Void>()
let source = PublishSubject<String>()

// withLatestFrom과 distinctUntilChanged를 합친 연산자임.
// 트리거 옵저버블이 Next 이벤트를 전달할 때마다 소스 옵저버블이 Next 이벤트를 방출하지만, 동일한 Next 이벤트를 반복해서 방출하지 않음.
source.sample(trigger) // ❗️ 순서가 withLatestFrom 연산자와 반대임!
    .subscribe { print($0) }
    .disposed(by: disposeBag)

trigger.onNext(())

source.onNext("Swift")
source.onNext("RxSwift")

trigger.onNext(())
trigger.onNext(())

// 소스 옵저버블이 Completed 이벤트를 방출해야, 시퀀스가 종료됨.
source.onCompleted()
trigger.onNext(())
