import UIKit
import RxSwift

//: # interval

let disposeBag = DisposeBag()

// 지정된 주기마다 정수를 방출함. 무한정 정수를 방출하므로 take 연산자 등으로 방출되는 이벤트 수에 제한을 둬야 함.
// 한 가지 주의해야 할 점은 타이머는 '옵저버가 옵져버블을 구독한 시점'에 생성됨. 새로운 구독이 발생하면 새로운 타이머가 생성됨.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
