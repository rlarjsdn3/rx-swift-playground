//
//  BindingViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import RxSwift
import RxCocoa

class BindingViewController: UIViewController, ViewControllerType {
    
    // MARK: - Views
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var valueLabel: UILabel!
    
    // MARK: - Property
    let viewModel: BindingViewModel = BindingViewModel()
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueField.placeholder = "입력"
        valueField.becomeFirstResponder()
    
        binding()
    }
    
    /* ⭐️ Binding
     * - Observable이 방출하는 항목을 UI에 바인딩하고자 할 때 유용한 Observer입니다.
     * - error와 completed 항목을 전달받지 않고, 메인 쓰레드에서 실행되는 걸 보장합니다.
     * - subscribe 메서드보다 더 간편하고 편리하게 사용할 수 있다는 장점이 있습니다.
     */
    
    func binding() {
        let input = BindingViewModel.Input(
            text: valueField.rx.text.orEmpty.asObservable()
        )
        let output = viewModel.transform(input)
        
        output.capitalizedString
            .distinctUntilChanged()
            .drive(valueLabel.rx.text)
            .disposed(by: disposeBag)
    }

}
