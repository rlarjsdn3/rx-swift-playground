import UIKit
import RxSwift

//: # throttle

let disposeBag = DisposeBag()

func currentTimeString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return formatter.string(from: Date())
}

// 일정 주기 동안 최근 하나의 이벤트만 방출함.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .debug()
    .take(10)
    // ・ true: 주기를 정확하게 지킴.
    // ・ false: 주기를 유하게 지킴. 주기가 지난 이후에 처음으로 방출되는 이벤트를 방출함.
    .throttle(.seconds(2), latest: false, scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
