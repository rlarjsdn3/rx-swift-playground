import UIKit
import RxSwift

func currentTimeString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return formatter.string(from: Date())
}

//: # delay
//: `Observable`이 `next` 항목 방출을 일정 시간만큼 지연시키는 연산자입니다.

let disposeBag = DisposeBag()

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .debug()
    .delay(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe { print(currentTimeString(), $0) }
    .disposed(by: disposeBag)

//: # subscriptionDelay
//: `Observable`을 구독하는 시점을 일정 시간만큼 지연시키는 연산자입니다. 단, `next` 항목을 방출하는 시점은 지연시키지 않습니다.

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .debug()
    .delaySubscription(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe { print(currentTimeString(), $0) }
    .disposed(by: disposeBag)
