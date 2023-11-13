import UIKit
import RxSwift

//: # Observable

let disposeBag = DisposeBag()

// 이벤트를 차례로 방출하는 Observable 시퀀스 생성
let observable = Observable<Int>.create { observer -> Disposable in
    // '10'이라는 이벤트 방출
    observer.on(.next(10))
    // '20'이라는 이벤트 방출
    observer.onNext(20)
    
    // 모든 이벤트를 전달했다는 '완료' 이벤트 방출
    observer.onCompleted()
    // Observable과 관련된 리소스를 모두 해제
    return Disposables.create()
}

// 옵져버블 시퀀스를 구독해 차례대로 이벤트를 받아 처리
observable
    .subscribe { print($0) }
    .disposed(by: disposeBag)
