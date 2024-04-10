import UIKit
import RxSwift

//: # combineLatest
//: `Observable`이 최근 방출한 항목을 묶은 결과값 항목을 방출하는 연산자입니다. 어느 `Observable`이 항목을 방출하지 않으면 결과값 항목을 방출하지 않습니다.

let disposeBag = DisposeBag()

let languages = PublishSubject<String>()
let greetings = PublishSubject<String>()

Observable<String>.combineLatest(
    [greetings, languages]
)
.map { $0.joined(separator: ", ") }
.subscribe {
    print("Received Value: \($0)")
}
.disposed(by: disposeBag)

greetings.onNext("Hello")
languages.onNext("Swift")

languages.onNext("Combine")
languages.onNext("RxSwift")

greetings.onNext("Good Bye")

languages.onCompleted()
greetings.onCompleted()
