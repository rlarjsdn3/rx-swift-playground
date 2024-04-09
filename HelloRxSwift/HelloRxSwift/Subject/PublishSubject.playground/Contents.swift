import UIKit
import RxSwift

//: # PublishSubject
//: `PublishSubject`는 구독하기 전에 방출한 항목을 전달받을 수 없는 `Subject`입니다.

//: `Subject`는 `Observable`인 동시에, `Observer`입니다. 각 `Subject`는 구독하기 전에 방출한 항목을 어떻게 처리할 지 차이만 있을 뿐, 기본적인 매커니즘은 모두 동일합니다. `Observable`과 마찬가지로, 모든 유형의 항목을 방출할 수 있습니다.

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let subject = PublishSubject<Int>()

subject.onNext(1)

subject
    .subscribe {
        print("S1 - Received Value: \($0)")
    }
    .disposed(by: disposeBag)

subject.onNext(2)

subject
    .subscribe {
        print("S2 - Received Value: \($0)")
    }
    .disposed(by: disposeBag)

subject.onNext(3)
subject.onNext(4)

subject.onCompleted()
