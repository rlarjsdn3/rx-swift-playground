import UIKit
import RxSwift

//: # compactMap
//: 소스 `Observable`이 방출하는 옵셔널(Optional) 항목을 해제하고, 해제가 불가능하다면(nil 이라면) 필터링하는 연산자입니다. 이후 동작은 map 연산자와 동일합니다.

let disposeBag = DisposeBag()

let numOfArray = Array(0...5)
let romanNumeralDict: [Int: String] = [1: "I", 2: "II", 3: "III", 5: "V"]

Observable<Int>.from(numOfArray)
    .compactMap { romanNumeralDict[$0] }
    .subscribe {
        print("Recevied Value: \($0)")
    }
    .disposed(by: disposeBag)
