import UIKit
import RxSwift

//: # deferred
//: `Observable`을 반환하는 클로저를 전달하고, 구독할 때마다 해당 클로저로 새로운 `Observable`을 반환하는 `Observable`을 선언합니다. (lazy 키워드처럼) `Observable`을 생성할 때 항목 생성을 지연시키는 효과가 있습니다.

let disposeBag = DisposeBag()

var flag = true
let alphabet = ["A", "B", "C"]
let hangeol = ["가", "나", "다"]

let deferred = Observable.deferred {
    flag.toggle()
    
    if flag {
        return Observable<String>.from(alphabet)
    } else {
        return Observable<String>.from(hangeol)
    }
}

deferred
    .subscribe { print("Received Value: \($0)") }
    .disposed(by: disposeBag)

deferred
    .subscribe { print("Received Value: \($0)") }
    .disposed(by: disposeBag)
