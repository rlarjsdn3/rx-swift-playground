import UIKit
import RxSwift

//: # ignoreElements

let disposeBag = DisposeBag()
let fruits = ["🍏", "🍎", "🍋", "🍓", "🍇"]

// 옵져버블이 방출하는 모든 Next 이벤트를 무시함. (Completed와 Error 이벤트만 방출함)
Observable.from(fruits)
    .ignoreElements()
    .subscribe { print($0) }
    .disposed(by: disposeBag)
