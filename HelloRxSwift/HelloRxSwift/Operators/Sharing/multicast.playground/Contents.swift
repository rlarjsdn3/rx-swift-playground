import UIKit
import RxSwift

//: # multicast
//: `Observable`이 방출하는 항목을 여러 `Observer`에게 공유하도록 유니캐스트에서 멀티캐스트로 바꿔주는 연산자입니다. 매개변수로 `Subject`를 전달해야 합니다. 모든 `Observer`가 구독을 하고, connect() 메서드를 호출해야 합니다.

let disposeBag = DisposeBag()

let subject = PublishSubject<(String, Int)>()

let numbers = ["First", "Second", "Thrid"]
let observable = Observable<String>.from(numbers)
    .map { ($0, Int.random(in: 0...100)) }
    .debug("Random")
    .multicast(subject)

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
