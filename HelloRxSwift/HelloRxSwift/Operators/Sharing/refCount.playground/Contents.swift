import UIKit
import RxSwift

//: # refCount
//: 새로운 `Observer`가 추가되는 시점에 자동으로 connect() 메서드를 호출해주는 연산자입니다.

let disposeBag = DisposeBag()

let numbers = ["First", "Second", "Thrid"]
let observable = Observable<String>.from(numbers)
    .map { ($0, Int.random(in: 0...100)) }
    .debug("Random")
    .publish()
    .refCount()

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

//observable.connect()
