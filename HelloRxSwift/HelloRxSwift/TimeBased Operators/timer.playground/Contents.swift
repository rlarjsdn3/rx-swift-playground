import UIKit
import RxSwift

//: # timer

let disposeBag = DisposeBag()

// 지연 시간과 반복 주기를 지정해서 정수를 방출함.
Observable<Int>.timer(.seconds(2), period: .seconds(3), scheduler: MainScheduler.instance)
    .take(10) // 2초 지연 후, 3초 주기마다 이벤트를 방출함.
    .subscribe { print($0) }
    .disposed(by: disposeBag)
