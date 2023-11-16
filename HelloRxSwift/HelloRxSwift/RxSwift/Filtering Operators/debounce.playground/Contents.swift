import UIKit
import RxSwift

//: # debounce

let disposeBag = DisposeBag()

// 옵저버블이 이벤트를 방출하고, 일정 주기 내 다른 이벤트를 방출하지 않는다면, 최근 방출한 이벤트를 방출함.
Observable<String>.create { observer in
    DispatchQueue.global().async {
        for i in 1...10 {
            observer.onNext("Tap - \(i)")
            Thread.sleep(forTimeInterval: 0.3)
        }
        
        Thread.sleep(forTimeInterval: 1.0)
        
        for i in 11...20 {
            observer.onNext("Tap - \(i)")
            Thread.sleep(forTimeInterval: 0.5)
        }
        
        observer.onCompleted()
    }
    
    return Disposables.create()
}
.debounce(.milliseconds(400), scheduler: MainScheduler.instance)
.subscribe { print($0) }
.disposed(by: disposeBag)
