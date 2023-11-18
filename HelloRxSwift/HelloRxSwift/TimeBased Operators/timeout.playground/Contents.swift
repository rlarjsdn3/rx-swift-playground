import UIKit
import RxSwift

//: # timeout

let disposeBag = DisposeBag()

let subject = PublishSubject<Int>()

// 지정된 시간 이내에 요소를 방출하지 않으면 에러 이벤트를 전달함.
subject
    .timeout(.seconds(3), other: Observable.just(-999), scheduler: MainScheduler.instance) // 지정된 시간 이내에 요소를 방출하지 않으면, other 파라미터로 전달된 옵저버블로 교체됨.
    .subscribe { print($0) }
    .disposed(by: disposeBag)

Observable<Int>.timer(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe { subject.onNext($0.element ?? 0) }
    .disposed(by: disposeBag)
