import UIKit
import RxSwift

//: # Publish
//: `PublishSubject`를 생성해 multicast 연산자의 매개변수로 전달하는 연산자입니다.

let disposeBag = DisposeBag()

let numbers = ["First", "Second", "Thrid"]
let observable = Observable<String>.from(numbers)
    .map { ($0, Int.random(in: 0...100)) }
    .debug("Random")
    .publish()

observable
    .subscribe {
        print("Stream 1 Received: \($0)")
    }
    .disposed(by: disposeBag)

observable
    .subscribe {
        print("Stream 2 Received: \($0)")
    }
    .disposed(by: disposeBag)

observable.connect()
