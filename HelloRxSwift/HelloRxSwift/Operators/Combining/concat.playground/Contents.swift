import UIKit
import RxSwift

//: # concat
//: 여러 `Observable`을 순서대로 합쳐 `next` 항목을 방출하는 연산자입니다.

let disposeBag = DisposeBag()

let fruits = Observable.from(["🍏", "🍎", "🥝", "🍑", "🍋", "🍉"])
let animals = Observable.from(["🐶", "🐱", "🐹", "🐼", "🐯", "🐵"])

Observable<String>.concat(fruits, animals)
    .subscribe {
        print("Received Valiue: \($0)")
    }
    .disposed(by: disposeBag)
