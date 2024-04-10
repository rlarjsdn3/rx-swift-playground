import UIKit
import RxSwift

//; # concapMap
//: 소스 `Observable`이 방출하는 `next` 항목을 대상으로 클로저를 실행해 새로운 이너 `Observable`로 변환하는 연산자입니다. 이너 옵저버블이 생성된 순서대로 항목을 방출합니다.

let disposeBag = DisposeBag()

let numOfArray = Array(1...9)
Observable<Int>.from(numOfArray)
    .concatMap { value in
        return Observable<[Int]>.create { observer  in
            var result: [Int] = []
            (1...9).forEach { number in
                result.append(value * number)
            }
            observer.onNext(result)
            return Disposables.create()
        }
    }
    .subscribe {
        print("Received Value: \($0)")
    }
    .disposed(by: disposeBag)
