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

/* ControlProperty 확장은 속성 항목을 방출하거나 속성의 변화를 관찰하는 역할을 수행할 필요가 있을 때 유용합니다.
 * 일반적으로, Observer만 수행한다면 Binder를 확장합니다.
 * Observable과 Observer의 역할을 동시에 수행한다면 ControlProperty를 확장합니다.
 */

extension Reactive where Base: UISlider {

    var color: ControlProperty<UIColor?> {
        // Getter는 Observable의 역할을 수행할 때
        controlProperty(editingEvents: .valueChanged) { slider in
            return UIColor(white: CGFloat(slider.value), alpha: 1.0)
        // Setter는 Observer의 역할을 수행할 때
        } setter: { slider, color in
            var white = CGFloat(1.0)
            color?.getWhite(&white, alpha: nil)
            slider.value = Float(white)
        }

    }
}


