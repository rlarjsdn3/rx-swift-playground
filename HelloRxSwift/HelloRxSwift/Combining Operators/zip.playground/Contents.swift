import UIKit
import RxSwift

//: # zip

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let numbers = PublishSubject<Int>()
let strings = PublishSubject<String>()

// 인덱스를 기준으로 짝을 맞추어 결합한 이벤트를 방출함. (Indexed Sequencing)
// 결합할 짝이 없는 이벤트는 구독자에게 전달되지 않음.
Observable.zip(numbers, strings) { "\($0): \($1)" }
    .subscribe { print($0) }
    .disposed(by: bag)

numbers.onNext(1)
strings.onNext("One")

numbers.onNext(2)
strings.onNext("Two")

numbers.onNext(3)
strings.onNext("Three")

strings.onNext("Four")

// 병합한 모든 옵저버블이 Completed 이벤트를 방출해야, 구독자에게 완료 이벤트를 방출함.
numbers.onCompleted()
strings.onCompleted()
