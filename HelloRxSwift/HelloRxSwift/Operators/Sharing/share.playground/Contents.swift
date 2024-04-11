import UIKit
import RxSwift

//: share
//: multicast, publish, refCount를 모두 합친 연산자입니다. 최대 버퍼 크기와 구독 공유 유지 범위를 지정할 수 있습니다.

let disposeBag = DisposeBag()

// 앞서 배운 모든 공유 연산자를 합친 연산자임.
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .debug()
    // forever: (구독이 없더라도) 버퍼를 계속 유지
    // whileConnected: 구독이 하나라도 존재하면 버퍼를 계속 유지
    .share(replay: 5, scope: .forever)
    // replay가 0이면 PublishSubject, 1 이상이면 ReplaySubject처럼 동작

let observable = Observable<Int>.from([1, 2, 3])
    .delay(.seconds(1), scheduler: MainScheduler.instance)
    .map { _ in Int.random(in: 0...100) }
    .debug("Random")
    .share(replay: 0, scope: .whileConnected)

observable
    .subscribe {
        print("Stream 1 Recevied: \($0)")
    }
    .disposed(by: disposeBag)

observable
    .subscribe {
        print("Stream 2 Received: \($0)")
    }
    .disposed(by: disposeBag)
