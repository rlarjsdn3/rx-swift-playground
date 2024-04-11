import UIKit
import RxSwift

//: # timeout
//: 지정 시간 내 `Observable`이 항목을 방출하지 않으면 `error` 항목을 전달하는 연산자입니다.

let disposeBag = DisposeBag()

let subject = PublishSubject<Int>()
subject
    .timeout(
        .seconds(2), 
        other: Observable<Int>.just(-1),
        scheduler: MainScheduler.instance
    )
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    subject.onNext(7)
}
