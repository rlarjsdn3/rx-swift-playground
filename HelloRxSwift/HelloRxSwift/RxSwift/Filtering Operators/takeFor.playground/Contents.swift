import UIKit
import RxSwift

//: takeFor

let disposeBag = DisposeBag()

// 지정한 시간 동안만 이벤트를 방출하게 함.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(for: .seconds(5), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
