import UIKit
import RxSwift

//: # schedular
//: `Observable`이 항목을 방출하거나, 항목이 `Operator`를 거칠 때 어느 쓰레드(Thread)에서 이를 수행하게 할 지 결정하게 하는 연산자입니다.

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

struct User: Decodable {
    var username: String
    var email: String
}

let myURL = URL(string: "https://jsonplaceholder.typicode.com/users")
let myRequest = URLRequest(url: myURL!)

URLSession.shared.rx.data(request: myRequest)
    // Observing Code 영역이 어느 쓰레드에서 수행하게 할 지 결정
    .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    .do(onNext: { _ in print("Main Thread: \(Thread.isMainThread)") })
    // Subscribing Code 영역이 어느 쓰레드에서 수행하게 할 지 결정
    .observe(on: MainScheduler.instance)
    .do(onNext: { _ in print("Main Thread: \(Thread.isMainThread)") })
    .decode(of: [User].self)
    .subscribe { print("Received Value: \($0)") }
    .disposed(by: disposeBag)
    
extension Observable where Element == Data {
    func decode<T>(of type: T.Type) -> Observable<T> where T: Decodable {
        flatMap { element in
            Observable<T>.create { observer in
                do {
                    let decoder = JSONDecoder()
                    let parsing = try decoder.decode(type, from: element)
                    observer.onNext(parsing)
                } catch {
                    observer.onError(MyError.error)
                }
                
                return Disposables.create()
            }
        }
    }
}
