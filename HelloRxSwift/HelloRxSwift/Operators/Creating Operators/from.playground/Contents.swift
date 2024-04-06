import UIKit
import RxSwift

//: # from

let disposeBag = DisposeBag()

// 배열 속 요소를 하나씩 꺼내어 방출하는 옵져버블 생성
//Observable<Int>.from([1, 2, 3, 4, 5])
//    .subscribe { print($0) }
//    .disposed(by: disposeBag)


Observable<Int>.from
    .subscribe { print($0) }
    .disposed(by: disposeBag)
