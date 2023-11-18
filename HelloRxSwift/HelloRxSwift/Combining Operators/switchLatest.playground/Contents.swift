import UIKit
import RxSwift

//: switchLatest

let disposeBag = DisposeBag()

let a = PublishSubject<String>()
let b = PublishSubject<String>()

let source = PublishSubject<Observable<String>>()

// 옵저버블을 방출하는 옵저버블에서 사용하는 연산자임.
// 가장 최근에 방출된 옵저버블을 구독하고, 이 옵저버블이 방출하는 이벤트를 구독자에게 전달함.
source
    .switchLatest()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

source.onNext(a)

a.onNext("Two")
a.onNext("Three")

source.onNext(b)

a.onNext("Four")

b.onNext("Five")
b.onNext("Six")

// 소스와 개별 옵저버블이 모두 Completed 이벤트를 방출해야, 시퀀스가 종료됨.
a.onCompleted()
b.onCompleted()
source.onCompleted()
