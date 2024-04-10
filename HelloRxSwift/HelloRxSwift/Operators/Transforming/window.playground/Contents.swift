import UIKit
import RxSwift

//: # window
//: 일정 주기 동안 `Observable`이 방출하는 항목을 수집하고, 최대 크기 버퍼에 도달하거나 일정 주기가 지나면 이너 `Observable`을 반환하는 연산자입니다.

let disposeBag = DisposeBag()

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .window(timeSpan: .seconds(3), count: 5, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe {
        guard let observable = $0.element else {
            return
        }
        
        observable.subscribe {
            print("Received Value: \($0)")
        }
    }
    .disposed(by: disposeBag)
