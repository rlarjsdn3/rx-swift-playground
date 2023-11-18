import UIKit
import RxSwift

//: # merge

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let oddNumbers = BehaviorSubject(value: 1)
let evenNumbers = BehaviorSubject(value: 2)
let negativeNumbers = BehaviorSubject(value: -1)

// 여러 옵저버블이 방출하는 이벤트를 하나의 옵저버블에서 방출하도록 병합함.
let source = Observable.of(oddNumbers, evenNumbers, negativeNumbers)

source
    // 병합 가능한 옵저버블의 최대 수는 2를 제한함.
    // 두 옵저버블 중 하나가 Completed 이벤트를 방출하면, 그 다음 옵저버블이 새롭게 병합됨.
    .merge(maxConcurrent: 2)
    //.merge() // 병합 가능한 옵저버블의 수에 제한을 두지 않음.
    .subscribe { print($0) }
    .disposed(by: disposeBag)

oddNumbers.onNext(3)
evenNumbers.onNext(4)

oddNumbers.onCompleted()

// 병합한 옵저버블 중 한번이라도 에러 이벤트를 방출하면, 구독자에게 에러 이벤트를 방출함.
//negativeNumbers.onError(MyError.error)

// 병합한 모든 옵저버블이 Completed 이벤트를 방출해야, 구독자에게 완료 이벤트를 방출함.
evenNumbers.onCompleted()
negativeNumbers.onCompleted()
