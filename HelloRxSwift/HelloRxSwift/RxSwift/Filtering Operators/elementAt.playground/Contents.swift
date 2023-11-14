import UIKit
import RxSwift

//: # elementAt

let disposeBag = DisposeBag()
let fruits = ["🍏", "🍎", "🍋", "🍓", "🍇"]

// 특정 인덱스에 위치한 이벤트만 제한적으로 방출함.
Observable.from(fruits)
    .element(at: 2)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
