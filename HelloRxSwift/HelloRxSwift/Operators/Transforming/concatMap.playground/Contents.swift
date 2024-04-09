import UIKit
import RxSwift

//; # concapMap

let disposeBag = DisposeBag()

let redCircle = "🔴"
let greenCircle = "🟢"
let blueCircle = "🔵"

let redHeart = "❤️"
let greenHeart = "💚"
let blueHeart = "💙"

// 원본 옵저버블이 방출하는 요소를 대상으로 함수를 실행하고, 결과를 새로운 이너 옵저버블로 반환함.
// 원본 옵져버블이 방출되는 이벤트의 수만큼 이너 옵져버블이 생성되며, 결과 옵져버블로 합쳐저 순차적으로 구독자에게 이벤트를 방출함.
Observable.from([redCircle, greenCircle, blueCircle])
    .concatMap { circle -> Observable<String> in
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
    // flatMap 연산자와는 다르게, 각 이너 옵져버블이 순서를 지킴.
    .subscribe { print($0) }
    .disposed(by: disposeBag)
