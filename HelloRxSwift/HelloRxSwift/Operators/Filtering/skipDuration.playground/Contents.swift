import UIKit
import RxSwift

//: # skip(duration:)

let disposeBag = DisposeBag()

// 지정한 기간 동안 옵져버블이 방출하는 이벤트를 무시함.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .skip(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
