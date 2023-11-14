import UIKit
import RxSwift

//: # range

let disposeBag = DisposeBag()

// 정수(Int)를 시작값부터 1씩 증가하는 시퀀스 요소를 하나씩 꺼내어 방출하는 옵져버블 생성
Observable<Int>.range(start: 0, count: 10)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

