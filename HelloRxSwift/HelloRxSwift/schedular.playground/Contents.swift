import UIKit
import RxSwift

//: # schedular

let disposeBag = DisposeBag()

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
let backgroundSchedular = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())

// ・ observe(on:) 메서드: 구독을 포함한 연산자가 실행할 쓰레드를 지정함. 순서가 중요함.
// ・ subscribe(on:) 메서드: 구독을 시작하고, 종료할 때 실행할 쓰레드를 지정함. 순서가 중요하지 않음.
Observable<Int>.from(numbers)
    .subscribe(on: MainScheduler.instance)
    .filter { num in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> filter")
        return num.isMultiple(of: 2)
    }
    .observe(on: backgroundSchedular)
    .map { num in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> map")
        return num * 2
    }
    .observe(on: MainScheduler.instance)
    .subscribe {
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> subscribe >>", "\($0)")
    }
    .disposed(by: disposeBag)
