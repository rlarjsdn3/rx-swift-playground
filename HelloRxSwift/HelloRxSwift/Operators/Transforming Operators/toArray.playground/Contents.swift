import UIKit
import RxSwift

//: # toArray

let disposeBag = DisposeBag()

// 옵저버블이 방출하는 모든 이벤트를 하나의 배열을 요소로 갖는 이벤트를 방출하는 싱글 옵저버블로 반환함.
let subject = PublishSubject<Int>()

subject
    .toArray()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(10)
subject.onNext(20)
subject.onNext(30)
// Completed 이벤트를 방출하면, 그 동안 전달한 모든 요소를 배열로 한데 묶어 이벤트로 방출함.
subject.onCompleted()

