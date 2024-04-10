import UIKit
import RxSwift

//: # distinctUntilChanged
//: `Observable`이 이전과 동일한 항목을 연속적으로 방출하는 걸 막아주는 연산자입니다.

struct Person {
    let name: String
    let age: Int
}

let disposeBag = DisposeBag()

let persons = [
    Person(name: "Sam", age: 12),
    Person(name: "Paul", age: 12),
    Person(name: "Tim", age: 56)
]

Observable<Person>.from(persons)
    .distinctUntilChanged(\.age)
    .subscribe {
        print("Recevied Value: \($0)")
    }
    .disposed(by: disposeBag)
