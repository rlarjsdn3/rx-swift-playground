import UIKit
import RxSwift

//: # retryWhen
//: `Observable`이 `error` 항목을 방출하면 트리거 `Observable`이 항목을 방출할 때 재시도(재방출)을 하게 하는 연산자입니다.

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let myURL = URL(string: "zzzz://www.apple.com")
let myRequest = URLRequest(url: myURL!)

let trigger = PublishSubject<Void>()

URLSession.shared.rx.data(request: myRequest)
    .retry(when: { _ in trigger })
    .map { String(data: $0, encoding: .utf8) }
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    trigger.onNext(())
}
