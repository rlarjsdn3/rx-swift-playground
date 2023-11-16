import UIKit
import RxSwift

//: # distinctUntilChanged

struct Person {
    let name: String
    let age: Int
}

let disposeBag = DisposeBag()
let numbers = [1, 1, 3, 2, 2, 3, 1, 5, 5, 7, 7, 7]
let tuples = [(1, "하나"), (1, "일"), (1, "one")]
let persons = [
    Person(name: "Sam", age: 12),
    Person(name: "Paul", age: 12),
    Person(name: "Tim", age: 56)
]

// 동일한 이벤트가 연속적으로 방출되는 것을 막아줌.
Observable.from(numbers)
    .distinctUntilChanged()
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// '동일한 이벤트'가 무엇인지 정의도 해줄 수 있음. (반환값이 true면 무시)
Observable.from(numbers)
    .distinctUntilChanged { old, new in
        !old.isMultiple(of: 2) && !new.isMultiple(of: 2) // 이전・이번 이벤트의 요소가 모두 짝수가 아니면 (홀수면) 무시
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)

// 튜플이나 구조체를 방출하는 이벤트도 '동일한 이벤트'가 무엇인지 정의해줄 수 있음.
Observable.from(tuples)
    .distinctUntilChanged { number, string in
        return number // 튜플의 첫 번째 요소를 기준으로 동일한 이벤트 유무를 판단함.
    }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
    
Observable.from(persons)
    .distinctUntilChanged(at: \.age)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
