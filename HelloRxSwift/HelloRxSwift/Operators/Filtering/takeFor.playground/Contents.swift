import UIKit
import RxSwift

//: takeFor
//: 지정한 시간 만큼 `Observable`이 항목을 방출하게 하는 연산자입니다.

let disposeBag = DisposeBag()

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(for: .seconds(3), scheduler: MainScheduler.instance)
    .subscribe {
        print("Recevied Value: \($0)")
    }
    .disposed(by: disposeBag)
