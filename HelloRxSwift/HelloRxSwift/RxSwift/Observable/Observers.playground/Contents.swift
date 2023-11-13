import UIKit
import RxSwift

//: # Observers

let disposeBag = DisposeBag()
let numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

// 옵져버블 시퀀스를 구독해 차례대로 이벤트를 받아 처리하는 객체를 'Observer(Subscriber)'라고 부름
Observable.from(numbers)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
