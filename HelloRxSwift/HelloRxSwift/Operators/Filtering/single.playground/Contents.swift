import UIKit
import RxSwift

//: # single

let disposeBag = DisposeBag()
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]

let subject = PublishSubject<Int>()

// 옵저버블이 단 하나의 이벤트만 방출하도록 함.
Observable<String>.just("Single")
    .single()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// 그런데, 옵저버블이 하나의 이벤트만 방출하지 못한다면 에러 이벤트를 방출함.
Observable<Int>.from(numbers)
    .single()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// 하나의 이벤트가 방출되었다 하더라도, 다른 이벤트가 방출될 수 있기 때문에 곧바로 completed 이벤트가 방출되는 건 아님.
subject
    .single()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

subject.onNext(10)
// 추가 이벤트를 방출한다면 에러 이벤트가 방출됨.
//subject.onNext(20)

subject.onCompleted()
