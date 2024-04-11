import UIKit
import RxSwift

//: # interval
//: 일정 주기마다 정수값 항목을 방출하는 연산자입니다. 무한정 방출하므로 take 연산자 등으로 항목에 제한을 두어야 합니다. 타이머는 `Observable`을 구독하는 시점에 생성됩니다.

let disposeBag = DisposeBag()

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)


