import UIKit
import RxSwift

//: # Single
//: `Single`은 단 하나의 `success` 혹은 `failure` 항목을 방출하는 `Traits`입니다. `next`와 `complete`을 합친 항목이 바로 `success`입니다. `failure`는 `error` 항목과 같습니다.

let disposeBag: DisposeBag = DisposeBag()

enum MyError: Error {
    case networkError
    case parsingError
}

typealias PostType = [[String: Any]]
func fetchPost() -> Single<PostType> {
    return Single<PostType>.create { single in
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                single(.failure(MyError.networkError))
                return
            }
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                  let result = json as? PostType else {
                single(.failure(MyError.parsingError))
                return
            }
            
            single(.success(result))
        }
        
        task.resume()
        
        return Disposables.create()
    }
}

fetchPost()
    .subscribe { event in
        switch event {
        case let .success(post):
            print("Post Fetch Result: \(post)")
        case let .failure(error):
            print("Error: \(error)")
        }
    }
    .disposed(by: disposeBag)
