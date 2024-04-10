import UIKit
import RxSwift

//: # throttle
//: 일정 주기 동안 `Observable`이 방출하는 최근 혹은 처음 항목을 전달하는 연산자입니다.

let disposeBag = DisposeBag()

Observable<Int>.interval(.seconds(3), scheduler: MainScheduler.instance)
    .debug("\(Date().description)")
    // latest-true: 주기가 끝나는 시점에 마지막 항목 방출O
    // latest-false: 주지가 끝나는 시점에 마지막 항목 방출X
    .throttle(.seconds(10), latest: false, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe {
        print("Recevied Value: \($0)")
    }
    .disposed(by: disposeBag)
