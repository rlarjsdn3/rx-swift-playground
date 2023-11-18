import UIKit
import RxSwift

//: # buffer

let disposeBag = DisposeBag()

// 일정 주기 동안 이벤트를 수집하고, 배열을 요소로 하는 이벤트를 방출함. 이를 컨트롤드 버퍼링( Controlled Buffering)이라 함.
// 주기가 지나거나, 최대 버퍼 카운트에 도달하면 곧바로 이벤트를 방출함.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .buffer(timeSpan: .seconds(3), count: 5, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
