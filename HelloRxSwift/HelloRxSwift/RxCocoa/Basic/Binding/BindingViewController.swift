//
//  BindingViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import RxSwift
import RxCocoa

class BindingViewController: UIViewController {
    
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var valueLabel: UILabel!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueField.placeholder = "입력"
        valueField.becomeFirstResponder()
        
//        valueField.rx.text
//            .observe(on: MainScheduler.instance)
//            .subscribe { [weak self] value in
//                self?.valueLabel.text = value
//            }
//            .disposed(by: disposeBag)
        
        // ⭐️ Bindig 기본 이론:
        // 옵저버블의 결과를 UI나 다른 데이터 소스에 바인딩하는 데 사용함.
        // 매 입력 시, RxCocoa가 확장한 text 컨트롤 프로퍼티(옵저버블)가 현재 입력된 텍스트가 담긴 Next 이벤트를 방출함.
        // subscirbe와는 다르게 에러 이벤트를 전달받지 않고, 메인 쓰레드에서 실행되는 걸 보장함.
        valueField.rx.text
            .bind(to: valueLabel.rx.text) // 옵저버블이 방출한 이벤트를 옵저버에게 전달함. (즉, text 컨트롤 프로퍼티가 방출한 이벤트를 text 컨트롤 프러퍼티에게 전달함)
            .disposed(by: disposeBag)
        
    }

}
