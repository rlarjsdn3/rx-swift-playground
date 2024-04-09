import UIKit
import RxSwift

//: # groupBy

let disposeBag = DisposeBag()
let words = ["Apple", "Banana", "Orange", "Book", "City", "Axe"]

// 방출되는 이벤트를 조건에 따라 그룹핑한 결과를 이너 옵져버블로 반환함.
Observable<String>.from(words)
    .groupBy { $0.first ?? Character(" ") }
    .flatMap { $0.toArray() }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
