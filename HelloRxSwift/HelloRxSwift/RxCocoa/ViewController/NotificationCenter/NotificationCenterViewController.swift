//
//  NotificationCenterViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import RxSwift
import RxCocoa

class NotificationCenterViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var toggleButton: UIBarButtonItem!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        toggleButton.rx.tap
            .subscribe { [unowned self] _ in
                if self.textView.isFirstResponder {
                    self.textView.resignFirstResponder()
                } else {
                    self.textView.becomeFirstResponder()
                }
            }
            .disposed(by: disposeBag)
        
        // 일반적인 노티피케이션과는 다르게, 해제가 자동으로 이루어짐
        let keyboardWillShowObservable = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? CGFloat(0.0) }
        
        let keyboardWillHideObservable = NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0.0) }
        
        Observable.merge(keyboardWillShowObservable, keyboardWillHideObservable)
            .map { [unowned self] height -> UIEdgeInsets in
                var inset = self.textView.contentInset
                inset.bottom = height
                return inset
            }
            .subscribe { [unowned self] inset in
                UIView.animate(withDuration: 0.3) {
                    self.textView.contentInset = inset
                    self.textView.scrollIndicatorInsets = inset
                }
            }
            .disposed(by: disposeBag)
    }
    
}
