import UIKit
import RxSwift

//: # ReplaySubject

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

// Replay Subject는 지정된 수 만큼 방출된 이벤트를 (후입선출) 버퍼에 저장해놓고, 새로운 구독자에게 버퍼에 저장된 이벤트를 방출함.
let replaySubject = ReplaySubject<Int>.create(bufferSize: 3)

(1...10).forEach { replaySubject.onNext($0) }

replaySubject
    .subscribe { print("Subscribe 1 - ", $0) }
    .disposed(by: disposeBag)

replaySubject.onNext(11) // 새로운 이벤트를 방출하면 마지막으로 추가된 이벤트가 버퍼에서 제거되고, 새로운 이벤트가 버퍼에 추가됨

replaySubject
    .subscribe { print("Subscribe 2 - ", $0) }
    .disposed(by: disposeBag)

//replaySubject.onError(MyError.error)
replaySubject.onCompleted()
