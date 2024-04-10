import UIKit
import RxSwift

//: # zip
//: `Observable`이 방출한 항목을 Index를 기준으로 짝을 맞출 수 있다면 합쳐서 항목을 방출하는 연산자입니다. 짝이 없다면 항목을 방출하지 않습니다.

let disposeBag = DisposeBag()

let number = PublishSubject<Int>()
let letter = PublishSubject<String>()

Observable.zip(number, letter)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)

number.onNext(1)
letter.onNext("One")

number.onNext(2)
number.onNext(3)
letter.onNext("Two")

number.onNext(4)
letter.onNext("Three")

number.onCompleted()
letter.onCompleted()
