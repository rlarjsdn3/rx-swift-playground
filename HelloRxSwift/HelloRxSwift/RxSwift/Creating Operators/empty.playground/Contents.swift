import UIKit
import RxSwift

//: # empty

let disposeBag = DisposeBag()

// 요소를 방출하지 않는 특별한 옵져버블 생성
Observable<Void>.empty()
    .subscribe { print($0) }
    .disposed(by: disposeBag)
