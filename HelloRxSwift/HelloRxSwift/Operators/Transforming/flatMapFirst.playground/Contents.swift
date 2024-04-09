import UIKit
import RxSwift

//; # flatMapFirst

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redHeart = "❤️"
let greenHeart = "💚"
let blueHeart = "💙"

// ⭐️ flatMapFirst와 flatMapLast는 생성된 이너 옵져버블의 우선순위에 따른 차이가 있음.

// 가장 먼저 방출한 이너 옵져버블만 결과 옵져버블에게 전달되고, 나머지 이너 옵져버블은 앞서 전달된 이너 옵져버블이 모든 이벤트를 방출할 때까지 무시됨.
// 이후 동작은 flatMap 연산자와 동일함.
Observable.from([redCircle, greenCircle, blueCircle])
    .flatMapFirst { circle -> Observable<String> in
        switch circle {
        case redCircle:
            return Observable.repeatElement(redHeart).take(5)
        case greenCircle:
            return Observable.repeatElement(greenHeart).take(5)
        case blueCircle:
            return Observable.repeatElement(blueHeart).take(5)
        default:
            return Observable.just("")
        }
    }
    // 그런데, 이너 옵져버블이 생성되면 결과 옵져버블에서 지연없이 이벤트를 방출하기 때문에 순서에 맞게 이벤트를 방출하는 건 아님.
    // 순서를 지키고 싶다면, concatMap 연산자를 사용해야 함.
    .subscribe { print($0) }
    .disposed(by: disposeBag)
