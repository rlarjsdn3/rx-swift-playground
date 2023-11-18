import UIKit
import RxSwift

//: # error

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// 에러를 방출하는 특별한 옵져버블 생성
Observable<Void>.error(MyError.error)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
