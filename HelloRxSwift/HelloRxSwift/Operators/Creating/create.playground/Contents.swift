import UIKit
import RxSwift

//: # create
//: 직접 `Observable`의 동작을 제어할 수 있는 `Observable`을 선언합니다. 네트워크 통신과 같은 복잡한 로직을 처리해야 하는 경우에 유용합니다.

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

typealias PostType = [String: Any]
func fetchPost(url: URL) -> Observable<[PostType]> {
    let request = URLRequest(url: url)
    
    return Observable<[PostType]>.create { observer in
        let task = URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let data = data,
                  let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [PostType] else {
                observer.onError(MyError.error)
                return
            }
            
            observer.onNext(dict)
        }
        
        task.resume()
        
        return Disposables.create()
    }
}

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

fetchPost(url: url)
    .retry(3)
    .subscribe { print("Received Value: \($0)") }
    .disposed(by: disposeBag)
