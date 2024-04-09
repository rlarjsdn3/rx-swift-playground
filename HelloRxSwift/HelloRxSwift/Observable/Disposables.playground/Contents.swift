import UIKit
import RxSwift

//: # Disposables
//: `Observable`은 모든 항목을 방출해 쓸모가 없어지면 해제를 해야 합니다. `Disposables`로 `Observable`을 해제하지 않으면 `Observable`이 사라지지 않아 메모리 누수가 발생할 위험이 있습니다. `dispose` 메서드를 호출하는 것보다 `DisposeBag`을 사용하는 게 더 효율적입니다. `DisposeBag`은 뷰가 사라질 때, 연관된 `Observable`을 메모리에서 해제합니다.

let disposeBag = DisposeBag()

let observable = Observable<Int>.of(1, 2, 3)
    .subscribe { event in
        switch event {
        case let .next(element):
            print("Element: \(element)")
        case .error:
            print("Error")
        case .completed:
            print("Completed")
        }
    }

observable.disposed(by: disposeBag)
