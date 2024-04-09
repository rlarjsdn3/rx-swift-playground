//
//  CustomBindingViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import RxSwift
import RxCocoa

class CustomBindingViewController: UIViewController {
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var colorPicker: UISegmentedControl!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 커스텀 바인드는 옵저버 역할만 수행해야 할 때 적합함.
        colorPicker.rx.selectedSegmentIndex
            .bind(to: valueLabel.rx.segmentedValue)
            .disposed(by: disposeBag)
    }

}

extension Reactive where Base: UILabel {
    // 전달받을 요소의 타입은 Int
    var segmentedValue: Binder<Int> {
        Binder(self.base) { label, index in
            switch index {
            case 0:
                label.text = "Red"
                label.textColor = .systemRed
            case 1:
                label.text = "Green"
                label.textColor = .systemGreen
            case 2:
                label.text = "Blue"
                label.textColor = .systemBlue
            default:
                label.text = "Unknwon"
                label.textColor = .systemGray5
            }
        }
    }
}

