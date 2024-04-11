import UIKit
import RxSwift

//: # retry
//: `Observable`이 `error` 항목을 방출하면 정한 횟수만큼 재시도(재방출)을 하게 하는 연산자입니다.

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let myURL = URL(string: "https://www.apple.com")
let myRequest = URLRequest(url: myURL!)

URLSession.shared.rx.data(request: myRequest)
    .retry(3)
    .map { String(data: $0, encoding: .utf8) }
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)
