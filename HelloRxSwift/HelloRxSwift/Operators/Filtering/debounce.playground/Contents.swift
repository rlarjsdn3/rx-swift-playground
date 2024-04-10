import UIKit
import RxSwift

//: # debounce
//: `Observable`이 항목을 방출할 때 일정 시간 내 다른 항목을 뒤이어 방출하지 않는다면, 최근에 방출한 항목을 전달하는 연산자입니다.

let disposeBag = DisposeBag()

let bounces: [(Int, TimeInterval)] = [
    (0, 0),
    (1, 0.25),  // 이전 인덱스와 0.25초 차이
    (2, 1),     // 이전 인덱스와 0.75초 차이
    (3, 1.25),  // 이전 인덱스와 0.25초 차이
    (4, 1.5),   // 이전 인덱스와 0.25초 차이
    (5, 2)      // 이전 인덱스와 0.5초 차이
]

let subject = PublishSubject<Int>()
subject
    .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)

for bounce in bounces {
    DispatchQueue.main.asyncAfter(deadline: .now() + bounce.1) {
        subject.onNext(bounce.0)
    }
}
