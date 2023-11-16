import UIKit
import RxSwift

//: # window

let disposeBag = DisposeBag()

// 일정 주기 동안 이벤트를 수집하고, 배열을 요소로 하는 이벤트를 방출하는 buffer와는 다르게,
// 이너 옵져버블을 반환함.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .window(timeSpan: .seconds(3), count: 5, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe {
        print($0)
        
        if let observable = $0.element {
            observable
                .subscribe { print("Inner - \($0)") }
                // 이너 옵져버블은 수동으로 dispose 메서드를 호출해야 할 필요가 없음.
        }
    }
    .disposed(by: disposeBag)
