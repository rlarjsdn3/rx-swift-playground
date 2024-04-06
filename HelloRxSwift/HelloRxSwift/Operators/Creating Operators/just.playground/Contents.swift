import UIKit
import RxSwift

//: # just

let disposeBag = DisposeBag()

// 단 하나의 요소를 방출하는 옵저버블 생성
Observable<String>.just("⭐️")
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// 배열 자체 요소를 방출하는 옵저버블 생성
Observable<[Int]>.just([1, 2, 3])
    .subscribe { print($0) }
    .disposed(by: disposeBag)
