//
//  CustomControlEventViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import RxSwift
import RxCocoa

class CustomControlEventViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.masksToBounds = false
        
        bind()
    }
    
    private func bind() {
        textField.rx.text
            .orEmpty
            .bind(to: valueLabel.rx.countValue)
            .disposed(by: disposeBag)
        
        textField.rx.editingDidBegin
            .map { UIColor.systemRed }
            .bind(to: textField.rx.borderColor)
            .disposed(by: disposeBag)
        
        textField.rx.editingDidEnd
            .map { UIColor.clear }
            .bind(to: textField.rx.borderColor)
            .disposed(by: disposeBag)
        
        doneButton.rx.tap
            .withUnretained(self)
            .subscribe { vc, _ in
                vc.textField.resignFirstResponder()
            }
            .disposed(by: disposeBag)
    }

}

/* ControlEvent 확장은 UI 이벤트 발생 시 수행해야 하는 로직을 달리 구현할 때 적합한 방법입니다.
 * (단, 이벤트로도 처리할 수 없는 복잡한 로직은 DelegateProxy를 사용해야 합니다)
 */

extension Reactive where Base: UITextField {
    var editingDidBegin: ControlEvent<Void> {
        controlEvent(.editingDidBegin)
    }
    
    var editingDidEnd: ControlEvent<Void> {
        controlEvent(.editingDidEnd)
    }
}

extension Reactive where Base: UILabel {
    var countValue: Binder<String> {
        Binder(self.base) { label, value in
            label.text = String(value.count)
        }
    }
}

extension Reactive where Base: UITextField {
    var borderColor: Binder<UIColor?> {
        Binder(self.base) { textField, value in
            textField.layer.borderColor = value?.cgColor
        }
    }
}
