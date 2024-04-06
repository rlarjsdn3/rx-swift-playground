import UIKit
import RxSwift

//: amb

let disposeBag = DisposeBag()

let a = PublishSubject<Int>()
let b = PublishSubject<Int>()

// switchLatest 연산자와 정반대임.
// 여러 옵저버블 중에서 가장 먼저 이벤트를 방출하는 옵저버블을 구독하고, 이 옵저버블이 방출하는 이벤트를 구독자에게 전달함.
Observable.amb([a, b])
    .subscribe { print($0) }
    .disposed(by: disposeBag)

a.onNext(10)
a.onNext(20)

b.onNext(10)

a.onCompleted()
