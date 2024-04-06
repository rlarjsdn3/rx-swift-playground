import UIKit
import RxSwift

//: # map

let disposeBag = DisposeBag()
let skills = ["Swift", "SwiftUI", "UIKit", "RxSwift"]

// 원본 옵저버블이 방출하는 요소를 대상으로 함수를 실행하고, 결과를 새로운 옵저버블로 반환함.
// 원본 옵져버블과 동일한 요소의 타입뿐만 아니라 다양한 타입으로 이벤트를 방출하는 게 가능함.
Observable<String>.from(skills)
    .map { skill in
        return "Hello, \(skill)!"
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

