import UIKit
import RxSwift

//: # concat

let disposeBag = DisposeBag()
let fruits = Observable.from(["🍏", "🍎", "🥝", "🍑", "🍋", "🍉"])
let animals = Observable.from(["🐶", "🐱", "🐹", "🐼", "🐯", "🐵"])

// 두 개의 옵져버블을 순서대로 연결함.
Observable<String>.concat([fruits, animals])
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// 스태틱 메서드 뿐만 아니라 인스턴스 메서드도 존재함.
// 처음 옵져버블이 completed 이벤트를 방출하면, 파라미터로 전달된 옵저버블을 연결함.
// 만약 중간에 에러 이벤트를 방출하면, 옵저버블을 연결하지 않음.
animals.concat(fruits)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
