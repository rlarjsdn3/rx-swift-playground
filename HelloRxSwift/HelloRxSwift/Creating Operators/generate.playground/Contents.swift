import UIKit
import RxSwift

//: # Generate

let red = "🔴"
let blue = "🔵"

let disposeBag = DisposeBag()

// 시작값부터 일정 값만큼 증가하는 시퀀스 요소를 하나씩 꺼내어 방출하는 옵져버블 생성
// (range와는 다르게 시퀀스가 정수일 필요는 없음)
Observable.generate(initialState: red) { value in
    return value.count < 15
} iterate: { next in
    return next.count.isMultiple(of: 2) ? next + red : next + blue
}
.subscribe { print($0) }
.disposed(by: disposeBag)
