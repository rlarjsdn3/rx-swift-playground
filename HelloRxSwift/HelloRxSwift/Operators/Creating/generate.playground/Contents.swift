import UIKit
import RxSwift

//: # Generate
//: 시작값부터 일정값만큼 증가하는 항목을 방출하는 `Observable`을 선언합니다.

let disposeBag = DisposeBag()

let red = "🔴"
let blue = "🔵"

Observable<String>.generate(initialState: blue) { value in
    value.count < 5
} iterate: { next in
    next.count.isMultiple(of: 2) ? next + blue : next + red
}
.subscribe { print("Received Value: \($0)") }
.disposed(by: disposeBag)
