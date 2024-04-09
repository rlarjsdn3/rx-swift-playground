import UIKit
import RxSwift

let disposeBag = DisposeBag()

func currentTimeString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return formatter.string(from: Date())
}

//: # delay

// Next 이벤트를 구독자에게 전달하는 시점을 지연시킴.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .debug()
    .delay(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe { print(currentTimeString(), $0) }
    .disposed(by: disposeBag)



//: # subscriptionDelay

// 구독이 이루어지는 시점을 지연시킴. (Next 이벤트를 전달하는 시점을 지연시키는 게 아님)
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .debug()
    .delaySubscription(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe { print(currentTimeString(), $0) }
    .disposed(by: disposeBag)
