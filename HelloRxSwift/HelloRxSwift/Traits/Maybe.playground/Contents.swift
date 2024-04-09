import UIKit
import RxSwift

//: # Maybe
//: `Maybe`는 `Single`과 `Completable`을 적절히 혼합한 형태의 `Traits`입니다. `Maybe`는 `success`, `completed` 혹은 `failure` 항목을 방출할 수 있습니다. 그래서 실직적인 값이 담긴 항목을 방출할 수도 있고, 하지 않을 수 있습니다.

let disposeBag: DisposeBag = DisposeBag()

enum MyError: Error {
    case invaildString
}

func generateString(_ string: String) -> Maybe<String> {
    return Maybe<String>.create { maybe in
        switch string {
        case "Swift":
            maybe(.success(string))
        case "SwiftUI":
            maybe(.completed)
        default:
            maybe(.error(MyError.invaildString))
        }
        
        return Disposables.create()
    }
}

generateString("Swift")
    .subscribe { result in
        switch result {
        case let .success(string):
            print("Received Value: \($0)")
        case .completed:
            print("Completed")
        case let .error(error):
            print("Error: \(error)")
        }
    }
    .disposed(by: disposeBag)
