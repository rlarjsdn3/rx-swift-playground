import UIKit
import RxSwift

//: # buffer
//: 일정 주기 동안 `Observable`이 방출하는 항목을 수집하고, 최대 크기 버퍼에 도달하거나 일정 주기가 지나면 곧바로 배열 항목을 방출하는 연산자입니다.

let disposeBag = DisposeBag()

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .buffer(timeSpan: .seconds(3), count: 5, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)
