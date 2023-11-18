import UIKit
import RxSwift

//: # withLatestFrom

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let trigger = PublishSubject<Void>()
let source = PublishSubject<String>()

// 트리거 옵저버블이 Next 이벤트를 방출하면 소스 옵저버블이 마지막으로 방출한 Next 이벤트를 구독자에게 전달함.
trigger.withLatestFrom(source) // ❗️ 순서에 신경써야 함!
    .subscribe { print($0) }
    .disposed(by: disposeBag)

source.onNext("Swift")
source.onNext("RxSwift")

trigger.onNext(())
trigger.onNext(())

source.onNext("Alamofire")
source.onNext("Kingfisher")

trigger.onNext(())

// 트리거 옵저버블이 Completed 이벤트를 방출해야, 시퀀스가 종료됨.
trigger.onCompleted()

