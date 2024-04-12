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
        
        colorPicker.rx.selectedSegmentIndex
            .bind(to: valueLabel.rx.segmentedValue)
            .disposed(by: disposeBag)
    }

}

// Binder 확장은 Observer가 수행해야 하는 로직을 달리 구현할 때 적합한 방법입니다.

extension Reactive where Base: UILabel {

    var segmentedValue: Binder<Int> {
        Binder(self.base) { label, index in
            switch index {
            case 0:
                label.textColor = .systemRed
            case 1:
                label.textColor = .systemGreen
            case 2:
                label.textColor = .systemBlue
            default:
                label.textColor = .systemGray5
            }
        }
    }
    
}

