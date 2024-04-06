import UIKit
import RxSwift

//: # Publish

let disposeBag = DisposeBag()

// multicast 연산자와 PublishSubject 서브젝트를 합친 연산자임.
// 내부적으로 PublishSubject를 만들어 multicast 연산자의 파라미터로 전달한 결과(ConnectableObservable)를 반환함.

let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(5)
    .publish()
//    .replay(3)

source
    .subscribe { print("🔵", $0) }
    .disposed(by: disposeBag)

source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print("🔴", $0) }
    .disposed(by: disposeBag)

source.connect()
