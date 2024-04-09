//
//  CustomControlPropertyViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import RxSwift
import RxCocoa

class CustomControlPropertyViewController: UIViewController {

    @IBOutlet weak var whiteSlider: UISlider!
    @IBOutlet weak var resetButton: UIButton!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 커스텀 컨트롤 프러퍼티는 옵저버블과 옵저버의 역할을 동시에 수행해야 할 때 적합함.
        whiteSlider.rx.color
            .bind(to: view.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .map { UIColor(white: 0.5, alpha: 1.0) }
            .bind(to: whiteSlider.rx.color.asObserver(), view.rx.backgroundColor.asObserver())
            .disposed(by: disposeBag)
    }
    
}

// 옵저버의 역할만 수행해도 된다면 커스텀 바인드를
// 옵저버블과 옵저버의 역할을 동시에 수행해야 한다면 커스텀 컨트롤 프로퍼티가 적합함.

extension Reactive where Base: UISlider {
    // 전달받거나 전달할 요소의 타입은 UIColor?
    var color: ControlProperty<UIColor?> {
        // 옵저버블의 역할을 수행한다면 getter
        controlProperty(editingEvents: .valueChanged) { slider in
            return UIColor(white: CGFloat(slider.value), alpha: 1.0)
        // 옵저버의 역할을 수행한다면 setter
        } setter: { slider, color in
            var white = CGFloat(1.0)
            color?.getWhite(&white, alpha: nil)
            slider.value = Float(white)
        }

    }
}


