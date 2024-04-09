import UIKit
import RxSwift

//: # combineLatest

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let greetings = PublishSubject<String>()
let languages = PublishSubject<String>()

// 소스 옵저버블이 방출하는 최신 이벤트를 병합함.
Observable<String>.combineLatest([greetings, languages])
    .map {
        $0.joined(separator: ", ")
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

greetings.onNext("Hello")
languages.onNext("Swift!")

languages.onNext("SwiftUI!")

languages.onNext("SwiftData!")

languages.onNext("RxSwift!")

greetings.onNext("Good Bye")

// 병합한 모든 옵저버블이 Completed 이벤트를 방출해야, 구독자에게 완료 이벤트를 방출함.
greetings.onCompleted()
languages.onCompleted()
