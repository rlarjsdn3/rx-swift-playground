import UIKit
import RxSwift

//: # compactMap

let disposeBag = DisposeBag()

// 원본 옵저버블이 방출하는 요소가 옵셔널이라면 자동으로 해제해주고, nil을 필터링함.
// 이후 동작은 map 연산자와 동일함.
let subject = PublishSubject<String?>()

subject
    .compactMap { $0 }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .map { _ in Bool.random() ? "⭐️" : nil }
    .subscribe { subject.onNext($0) }
    .disposed(by: disposeBag)
