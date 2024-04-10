import UIKit
import RxSwift

//: # toArray
//: `Observable`이 방출하는 모든 `next` 항목을 `completed` 항목이 방출될 때 배열로 묶어 방출하게 하는 연산자입니다.

let disposeBag = DisposeBag()

let subject = PublishSubject<Int>()

subject
    .toArray()
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)

subject.onCompleted()
