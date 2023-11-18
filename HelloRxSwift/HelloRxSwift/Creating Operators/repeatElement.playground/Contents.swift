import UIKit
import RxSwift

//: # repeatElment

let disposeBag = DisposeBag()

// 동일한 요소를 무한정 방출하는 옵져버블 생성
// (take 등 연산자로 방출하는 이벤트를 제어해줘야 함)
Observable.repeatElement("⭐️")
    .take(10)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
