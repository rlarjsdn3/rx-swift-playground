import UIKit
import RxSwift

//: # groupBy
//: `Observable`이 방출하는 항목을 주어진 조건에 따라 그룹핑(Grouping)한 항목을 이너 `Observable`로 반환하는 연산자입니다.

let disposeBag = DisposeBag()

let words = ["Apple", "Banana", "Orange", "Book", "City", "Axe"]

Observable<String>.from(words)
    .groupBy { $0.first! }
    .flatMap { $0.toArray() }
    .subscribe { print("Recevied Value: \($0)") }
    .disposed(by: disposeBag)
