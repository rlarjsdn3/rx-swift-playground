import UIKit
import RxSwift

//: # skipDuration
//: 지정한 시간 만큼 `Observable`이 방출하는 모든 항목을 무시하는 연산자입니다.

let disposeBag = DisposeBag()

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .skip(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)
