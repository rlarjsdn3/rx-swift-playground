import UIKit
import RxSwift

//: # Completable
//: `Completable`은 단 하나의 `completed` 혹은 `failure` 항목을 방출하는 `Traits`입니다. `Single`과는 다르게 어느 결과가 담긴 항목을 방출하지 않습니다. 오직 성공 혹은 실패와 같은 항목을 전파하는 데 주로 사용되는 `Traits`입니다.

let disposeBag: DisposeBag = DisposeBag()

enum MyError: Error {
    case networkError
    case parsingError
}

typealias PostType = [[String: Any]]
func fetchPost() -> Completable {
    return Completable.create { completable in
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completable(.error(MyError.networkError))
                return
            }
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                  let result = json as? PostType else {
                completable(.error(MyError.parsingError))
                return
            }
            
            completable(.completed)
        }
        
        task.resume()
        
        return Disposables.create()
    }
}

fetchPost()
    .subscribe{ result in
        switch result {
        case .completed:
            print("Post Fetch Completed")
        case let .error(error):
            print("Error: \(error)")
        }
    }
    .disposed(by: disposeBag)
