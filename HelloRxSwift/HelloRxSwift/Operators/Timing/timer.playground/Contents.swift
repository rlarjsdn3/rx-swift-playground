import UIKit
import RxSwift

//: # timer
//: 일정 시간 지연 후(duetime), 일정 주기마다 정수값 항목을 방출하는 연산자입니다.

let disposeBag = DisposeBag()

Observable<Int>.timer(
    .seconds(3),
    period: .seconds(2),
    scheduler: MainScheduler.instance
)
.take(10)
.subscribe {
    print("Received Value: \($0)")
}
.disposed(by: disposeBag)
