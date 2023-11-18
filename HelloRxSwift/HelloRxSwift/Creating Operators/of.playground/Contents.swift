import UIKit
import RxSwift

//: # of

let disposeBag = DisposeBag()

// 시퀀스 요소를 하나씩 방출하는 옵저버블 생성
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// 배열도 예외없이 하나의 요소로 방출하는 옵저버블 생성
Observable<[Int]>.of([1, 2,], [3, 4], [5])
    .subscribe { print($0) }
    .disposed(by: disposeBag)
