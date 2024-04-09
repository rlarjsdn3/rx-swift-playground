import UIKit
import RxSwift
import RxCocoa

//: # Hello, RxSwift!

let disposeBag = DisposeBag()

Observable.just("Hello, RxSwift!")
    .subscribe { print($0) }
    .disposed(by: disposeBag)
